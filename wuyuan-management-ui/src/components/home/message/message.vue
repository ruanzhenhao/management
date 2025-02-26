<template>
    <div class="mission">
        <div class="info">
            <div class="group_but">
                <el-button type="warning" plain round>全部清除 <i class="el-icon-delete"></i></el-button>
            </div>
        </div>
        <div class="table">
            <el-table :data="messageTableData" style="width: 100%" header-align="center">
                <el-table-column prop="sendUserName" label="发送者" width="230" align="center"></el-table-column>
                <el-table-column prop="title" label="标题" width="230" align="center"></el-table-column>
                <el-table-column prop="content" label="内容" width="*" align="center"></el-table-column>
                <el-table-column align="center" label="发送日期">
                    <template v-slot:default="scope">
                        {{ formatCreateTime(scope.row.createdTime) }}
                    </template>
                </el-table-column>
                <el-table-column prop="action" label="操作" width="250" align="center">
                    <template v-slot:default="scope">
                        <el-button type="primary" plain @click="yes(scope.row.teamID)" round
                            v-show="scope.row.type == '2'">同意</el-button>
                        <el-button type="danger" @click="no(scope.row.id)" plain round
                            v-show="scope.row.type == '2'">拒绝</el-button>
                    </template>
                </el-table-column>

            </el-table>
        </div>
    </div>
</template>

<script>
import { getMessage, submitNo, submitYes } from '@/api/Message';
export default {
    mounted() {
        this.getAllMessage();
    },
    data() {
        return {
            messageTableData:
                [

                ]
        };
    }, methods:
    {
        async yes(teamID) {
            const res = await submitYes(teamID);
            if (res.code === 200) {
                this.$message.success('已同意');
            } else {
                this.$message.error(res.msg);
            }
            this.getAllMessage();

        },
        async no(id) {
            const res = await submitNo(id);
            if (res.code === 200) {
                this.$message.success('已拒绝');
            } else {
                this.$message.error(res.msg);
            }
            this.getAllMessage();
        },

        async getAllMessage() {
            const res = await getMessage();
            if (res.code === 200) {
                this.messageTableData = res.data;
                console.log(this.messageTableData);
            } else {
                this.$message.error(res.msg);
            }
        },
        formatCreateTime(createdTime) {
            // 检查是否是有效的数组
            if (!Array.isArray(createdTime) || createdTime.length < 5) {
                return '未知时间';
            }

            const [year, month, day, hours, minutes] = createdTime;

            // 创建 Date 对象（注意：月份需要减去1）
            const date = new Date(year, month - 1, day, hours, minutes);

            // 格式化日期为 YYYY-MM-DD HH:mm:ss
            const formattedDate = date.toISOString().slice(0, 19).replace('T', ' ');

            return formattedDate;
        }
    }
};
</script>

<style lang="less" scoped>
.mission {
    margin-top: 2%;
    display: flex;
    flex-direction: column;
    /* 设置为列方向，按钮和表格垂直排列 */
    width: 97%;
    max-width: 2000px;
    min-width: 600px;
    background-color: rgb(255, 255, 255);
    border-radius: 30px;
    padding: 20px;
    /* 添加内边距 */
}

.group_but {
    margin-bottom: 1.5%;
    margin-left: 2.5%;

}

.table {
    width: 100%;
    /* 使表格宽度占满容器 */
}
</style>