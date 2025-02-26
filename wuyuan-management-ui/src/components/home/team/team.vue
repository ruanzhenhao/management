<template>
    <div class="container">
        <el-row :gutter="20" class="button-group">
            <div class="button-wrapper">
                <el-button type="info" class="action-button"
                    @click.native="$router.push('/api/admin/home/team/createTeam')">创建团队</el-button>
                <el-button type="info" class="action-button" @click="joinShow = true">加入团队</el-button>
            </div>
        </el-row>
        <div class="list-container">
            <ul class="item-list">
                <li v-for="(item, index) in items" :key="index" class="list-item" @click="TeamInfo(item.teamName)">
                    <h2 class="item-title">{{ item.teamName }}</h2>
                    <p class="item-description">{{ item.introduction }}</p>
                </li>
            </ul>
        </div>
        <div class="pagination">
            <el-pagination @current-change="handlePageChange" :current-page="currentPage" :page-size="itemsPerPage"
                background :total="total" layout="pager" />
        </div>
        <el-dialog title="加入团队" :visible.sync="joinShow" width="30%">
            <div slot="default">
                <el-input v-model="invitationCode" placeholder="请输入邀请码"></el-input>
            </div>
            <div slot="footer">
                <el-button class="action-button" @click="joinTeamSubmit">确定</el-button>
                <el-button @click="joinShow = false" class="action-button">取消</el-button>
            </div>
        </el-dialog>
    </div>
</template>

<script>
import { getTeamListData, joinTeam } from '@/api/team';
import { mapMutations } from 'vuex';

export default {
    data() {
        return {
            invitationCode: '',
            joinShow: false,
            currentPage: 1,
            total: 0,
            items: [],
            itemsPerPage: 7, // 默认每页显示的项目数

        };
    },
    computed: {
        displayedItems() {
            const start = (this.currentPage - 1) * this.itemsPerPage;
            console.log("start:" + start);

            // 处理越界情况
            if (start < 0 || start >= this.items.length) {
                return []; // 如果起始索引越界，返回空数组
            }

            return this.items.slice(start, start + this.itemsPerPage);
        }
    },
    methods: {
        ...mapMutations(['changeTeamName']),
        TeamInfo(teamName) {
            console.log("跳转页面" + teamName);
            this.changeTeamName(teamName);
            this.$router.push({ name: 'teamInfo', params: { teamName } });
        },
        handlePageChange(page) {
            this.currentPage = page;
            console.log("currentPage:" + this.currentPage);
            this.items = [];
            this.getTeamListData();
        },
        async getTeamListData() {
            const data = {
                page: this.currentPage,
                pageSize: this.itemsPerPage,
                start: this.start
            };
            const res = await getTeamListData(data);
            if (res.code === 200) {
                this.items = res.data.records;
                console.log("items:", this.items);
                this.total = res.data.total;
                console.log("total:", this.total);
            } else {
                this.$message.error(res.msg);
            }
        },
        async joinTeamSubmit() {
            const res = await joinTeam(this.invitationCode);
            if (res.code === 200) {
                this.$message.success("加入成功");
                this.getTeamListData();
                this.joinShow = false;
            } else {
                this.$message.error(res.msg);
            }
        }
    },
    mounted() {
        this.getTeamListData();
    }
};
</script>

<style scoped>
/* 你的样式保持不变 */
</style>

<style scoped>
html,
body {
    margin: 0;
    padding: 0;
    height: 100%;
    font-family: Arial, sans-serif;
}

.container {
    padding: 2em;
    /* 使用 em 作为单位 */
    height: 82%;
    width: 95%;
}

.button-group {
    margin-bottom: 2em;
    display: flex;
    justify-content: flex-end;
    /* 右对齐按钮组 */
}

.button-wrapper {
    display: flex;
    gap: 1em;
    /* 使用 em 作为单位 */
}

.action-button {
    transition: background-color 0.3s, transform 0.2s;
}

.action-button:hover {
    transform: scale(1.05);
}

.list-container {
    height: auto;
    /* 自适应高度 */
    width: 100%;
    background-color: rgba(255, 255, 255, 0.9);
    /* 半透明背景 */
    border-radius: 1.25em;
    /* 使用 em 作为单位 */
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
    display: flex;
    flex-direction: column;
    align-items: center;
    padding: 2em 1em;
    /* 使用 em 作为单位 */
}

.item-list {
    list-style-type: none;
    padding: 0;
    width: 95%;
    max-width: 1200px;
    /* 适当限制最大宽度 */
}

.list-item {
    background-color: #ffffff;
    border-radius: 0.9375em;
    /* 使用 em 作为单位 */
    padding: 1.25em;
    /* 使用 em 作为单位 */
    margin-bottom: 1.25em;
    /* 使用 em 作为单位 */
    box-shadow: 0 2px 6px rgba(0, 0, 0, 0.15);
    transition: transform 0.2s, box-shadow 0.2s;
}

.list-item:hover {
    transform: translateY(-4px);
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
}

.item-title {
    font-size: 1.5em;
    /* 使用 em 作为单位 */
    color: #2f3640;
    margin: 0 0 0.5em;
    /* 使用 em 作为单位 */
    transition: color 0.3s;
}

.item-title:hover {
    color: #0056b3;
}

.item-description {
    font-size: 1em;
    /* 使用 em 作为单位 */
    color: #666;
    line-height: 1.5;
    max-height: 40px;
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
}

.pagination {
    margin-top: 2em;
    /* 添加分页与列表之间的间距 */
    display: flex;
    justify-content: center;
    /* 居中分页 */
}
</style>