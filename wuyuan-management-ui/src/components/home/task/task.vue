<template>
    <div class="task-container">
        <div class="form">
            <el-form ref="selectTeamForm" :model="selectTeamForm" label-width="150px" :inline="true">
                <el-form-item label="选择团队">
                    <el-select v-model="selectTeamForm.teamName" clearable placeholder="请选择团队" class="select-team">
                        <el-option v-for="team in teamNameList" :key="team.id" :label="team.taskName"
                            :value="team.taskName"></el-option>
                    </el-select>
                </el-form-item>
                <el-form-item label-width="50px" label=" " class="form-item">
                    <el-button @click="selectTaskList" class="submit-button" plain>确定</el-button>
                </el-form-item>
            </el-form>
        </div>
        <div class="divider"></div>

        <div class="team-list">
            <div v-if="teamByList.length === 0">
                <h3 class="not-title">暂无内容</h3>
            </div>
            <div v-else>
                <div v-for="team in teamByList" :key="team.teamId" class="team-item">
                    <div class="team-info">
                        <div class="team-name">{{ team.teamName }}</div>
                        <div class="team-details">
                            <span class="team-boss">组长: {{ team.boss }}</span>
                            <br>
                            <span class="create-time">创建时间: {{ formatCreateTime(team.createTime) }}</span>
                        </div>
                    </div>
                    <div class="toggle-container" @click="toggleTasks(team.teamId)">
                        <i :class="isOpen(team.teamId) ? 'el-icon-arrow-up' : 'el-icon-arrow-down'"
                            class="toggle-icon"></i>
                    </div>
                    <div v-if="isOpen(team.teamId)" class="task-list">
                        <p v-if="!team.taskList || team.taskList.length === 0" class="no-tasks">暂无任务</p>
                        <ul v-else class="task-item-list">
                            <li v-for="task in team.taskList" :key="task.taskName" class="task-item">
                                <div class="task-details">
                                    <!-- <h1 class="task-name">{{ task.taskName }}</h1> -->
                                    <div class="task-details-line">
                                        <h1 class="task-name">{{ task.taskName }}</h1>
                                        <span class="demand">{{ task.demand }}</span><br>
                                    </div>
                                    <div class="date-button-container">
                                        <div class="button-container">
                                            <el-button type="primary" @click="goTosubmit(task.taskId)">提交任务 <i
                                                    class="el-icon-upload el-icon--right"></i></el-button>
                                        </div>
                                        <div class="validTime-container">
                                            <strong>发布者:</strong> <span>{{ task.createUserName }}</span><br />
                                            <span class="validTime">提交日期：{{ formatCreateTime(task.createTime) }} - {{
                                                formatCreateTime(task.endTime) }}</span>
                                        </div>
                                    </div>

                                </div>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
import { getTeamList } from '@/api/home/taskAndTeamData';
import { getTaskByTeam, getTaskByTeamID } from "@/api/task";
import { mapMutations, mapState } from 'vuex';

export default {
    data() {
        return {
            teamNameList: [],
            selectTeamForm: {
                teamName: ''
            },
            teamByList: [],
            openTeamIds: []
        };
    },
    mounted() {
        this.getTeamListData();
        this.selectTaskList();
        this.Log();
    },
    methods: {
        ...mapMutations(['changeTaskId']),
        goTosubmit(taskId) {
            console.log('id', taskId);
            this.changeTaskId(taskId);
            this.$router.push('/api/admin/home/task/submitTask');
        },
        nullList(teamId) {
            const team = this.teamByList.find(t => t.teamId === teamId);
            if (team) {
                team.taskList = []; // 重置任务列表
            }
        },
        Log() {
            console.log('teamNameList', this.teamNameList);
            console.log('teamByList', this.teamByList);
        },
        isOpen(teamId) {
            return this.openTeamIds.includes(teamId);
        },
        async toggleTasks(teamId) {
            const index = this.openTeamIds.indexOf(teamId);
            if (index > -1) {
                // 关闭任务列表
                this.openTeamIds.splice(index, 1);
                this.nullList(teamId); // 可选
            } else {
                // 打开任务列表并获取任务数据
                this.openTeamIds.push(teamId);
                const res = await getTaskByTeamID(teamId);
                if (res.code === 200) {
                    const team = this.teamByList.find(t => t.teamId === teamId);
                    if (team) {
                        team.taskList = res.data; // 更新任务列表
                    }
                } else {
                    this.$message.error(res.msg);
                }
            }
        },
        formatCreateTime(createTime) {
            return `${createTime[0]}-${createTime[1].toString().padStart(2, '0')}-${createTime[2].toString().padStart(2, '0')}`;
        },
        async getTeamListData() {
            const res = await getTeamList(10086);
            if (res.code === 200) {
                this.teamNameList = res.data;
            } else {
                this.$message.error(res.msg);
            }
        },
        async selectTaskList() {
            console.log("selectTeamForm", this.selectTeamForm);
            const res = await getTaskByTeam(this.selectTeamForm.teamName);
            if (res.code === 200) {
                this.teamByList = res.data;
                console.log("select", this.teamByList);
            } else {
                this.$message.error(res.msg);
            }
        }
    }
};
</script>

<style lang="less" scoped>
.task-container {
    width: 98%;
    padding-top: 1%;
    margin: 0 auto;
    background-color: rgb(255, 253, 255);
    border-radius: 40px;
    min-height: 700px;
    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
}

.form {
    padding-top: 22px;
}

.select-team {
    width: 100%;
}

.submit-button {
    width: 100%;
    height: 40px;
    font-size: 16px;
}

.divider {
    width: 90%;
    height: 1.5px;
    background-color: #e0e0e0;
    margin: 10px auto;
}

.team-list {
    width: 95%;
    margin: 0 auto;
    padding: 20px;
}

.not-title {
    color: #aaa;
    text-align: center;
}

.team-item {
    padding: 15px;
    border-radius: 20px;
    margin-bottom: 20px;
    background-color: #ffffff;
    box-shadow: 0 2px 12px rgba(0, 0, 0, 0.1);
}

.team-info {
    display: flex;
    flex-direction: column;
    align-items: flex-start;
}

.team-name {
    padding-top: 15px;
    padding-left: 20px;
    font-weight: bold;
    font-size: 25px;
    color: #333;
}

.team-details {
    padding-top: 5px;
    padding-left: 20px;
    margin-top: 15px;
    font-size: 16px;
    color: #666;
}

.toggle-container {
    display: flex;
    justify-content: flex-end;
    align-items: center;
    cursor: pointer;
}

.toggle-icon {
    font-size: 24px;
    color: #ccc;
}

.task-list {
    margin-top: 10px;
    /* 添加上边距以避免重叠 */
    padding: 10px;
    /* 内边距 */

    border-radius: 8px;
    /* 圆角 */
}

.no-tasks {
    text-align: center;
    /* 居中 */
    color: #999;
    /* 文本颜色 */
}

.task-item-list {
    list-style: none;
    /* 去掉默认列表样式 */
    padding: 0;
    /* 去掉默认内边距 */
    margin: 0;
    /* 去掉默认外边距 */
}

.task-item {
    background-color: #fff;
    /* 每项任务的背景色 */
    border-radius: 8px;
    /* 圆角 */
    padding: 10px;
    /* 内边距 */
    margin-bottom: 15px;
    /* 任务项之间的间距 */
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
    /* 阴影效果 */
    display: flex;
    /* 使用 Flexbox 布局 */
    justify-content: space-between;
    /* 内容两端对齐 */
    align-items: center;
    /* 垂直居中对齐 */
    transition: transform 0.3s ease, box-shadow 0.3s ease;
    /* 添加过渡效果 */
}

.task-item:hover {
    transform: translateY(-5px);
    /* 向上移动5px */
    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
    /* 增加阴影效果 */
}

.task-details {
    flex: 1;
    /* 使任务详情部分占据剩余空间 */
    padding-right: 10px;
    /* 任务详情与日期和按钮之间的间距 */
    text-align: left;
    /* 确保任务名称和需求左对齐 */
}

.task-details {
    flex: 1;
    /* 使任务详情部分占据剩余空间 */
    padding-right: 10px;
    /* 任务详情与日期和按钮之间的间距 */
    text-align: left;
    /* 确保任务名称和需求左对齐 */
}

.date-button-container {
    height: 100%;
    display: flex;
    /* 使用 Flexbox 布局 */
    flex-direction: column;
    /* 垂直排列 */
    align-items: flex-end;
    /* 右对齐 */
    justify-content: center;
    /* 垂直居中 */
}

.validTime-container {
    font-size: 14px;
    /* 字体大小 */
    color: #888;
    /* 字体颜色 */
    margin-bottom: 5px;
    /* 日期与按钮之间的间距 */
}

.button-container {
    align-self: flex-end;
    /* 按钮右对齐 */
}

.el-button {
    display: flex;
    margin-bottom: 30%;
    /* 使按钮与其他元素一致 */
}

.task-name {
    margin: 1.5% 0 1% 2.5%;
    /* 上下左右的外边距 */
    font-size: 25px;
    /* 任务名称字体大小 */
    font-weight: bold;
    /* 加粗 */
    color: #333;
    /* 任务名称颜色 */
}

.task-details-line {
    float: left;
    width: 80%;
    margin-top: 10px;
}

.demand {
    margin-top: 1%;
    /* 上外边距 */
    margin-left: 2.2%;
    /* 左外边距 */
    color: #666;
    /* 需求颜色 */
    font-size: 17px;
    /* 字体大小 */
}
</style>