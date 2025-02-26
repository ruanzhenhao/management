<template>
    <div class="check-task-container">
        <div class="form">
            <el-form ref="selectTaskForm" :model="selectTaskForm" label-width="150px" :inline="true">
                <el-form-item label="请选择任务">
                    <el-select v-model="taskID" clearable placeholder="请选择任务" class="select-team">
                        <el-option v-for="task in taskNameList" :key="task.id" :label="task.taskName"
                            :value="task.id"></el-option>
                    </el-select>
                </el-form-item>
                <el-form-item label-width="50px" label=" " class="form-item">
                    <el-button @click="selectTaskList" class="submit-button" plain>确定</el-button>
                </el-form-item>
            </el-form>
        </div>

        <div class="divider"></div>

        <div class="nocheck-num" v-if="checkTask.nocheck !== 0">
        </div>
        <div class="check-table">
            <el-table :data="checkTask.checkTaskList" style="width: 100%">
                <el-table-column prop="teamName" label="团队名" width="width" align="center">
                </el-table-column>
                <el-table-column prop="userName" label="提交者" width="width" align="center">
                </el-table-column>
                <el-table-column prop="taskName" label="任务名" width="width" align="center">
                </el-table-column>
                <el-table-column label="提交时间" width="width" align="center">
                    <template v-slot:default="scope">
                        {{ formatCreateTime(scope.row.submitTime) }}
                    </template>
                </el-table-column>
                <el-table-column label="操作" width="width" align="center">
                    <template slot-scope="scope">
                        <el-button @click="check(scope.row)" type="primary" size="small">审核</el-button>
                        <el-button @click="submitReturn(scope.row)" type="danger" size="small">退回</el-button>
                        <el-button @click="submitSuccess(scope.row)" type="success" size="small">完成</el-button>
                    </template>
                </el-table-column>
            </el-table>

        </div>
        <el-drawer title="审核任务" :visible.sync="drawer">
            <div class="info-submit">
                <span class="info-title">任务名 : {{ submit_info.taskName }}</span><br>
                <span class="info-title">提交人 : {{ submit_info.userName }}</span><br>
                <span class="info-title">提交时间 : {{ submit_info.submitTime }}</span>
            </div>

            <div class="submit_info">
                <div class="contend">
                    <h1 class="submit_info-title">正文</h1>
                    <span class="submit-info-contend">{{ submitInfoData.content }}</span>
                </div>


                <h1 class="submit_info-title">附件</h1>
                <div class="submit_info">
                    <el-button type="primary" v-if="submitInfoData.fileIds.length !== 0"
                        @click="downloadFiles">下载附件</el-button>
                    <span v-else style="color:#999;display: block; ">无</span>
                </div>
            </div>

            <div class="check-submit">
                <el-button type="success">审核通过</el-button>
                <el-button type="danger">驳回任务</el-button>
            </div>
        </el-drawer>
    </div>
</template>

<script>
import { getTaskTable, getaskList, getsubmitInfoData, getDownloadData, success, task_return } from '@/api/task';
export default {
    data() {
        return {
            drawer: false,
            selectTaskForm: {
                taskName: '',
            },
            taskID: null,
            taskNameList: [],
            checkTask: {
                checkTaskList: [],
                nocheck: 10
            },

            submit_info:
            {
                taskName: '',
                submitTime: '',
                userName: '',

            },
            submitInfoData:
            {
                content: '',
                fileIds: []
            },

        }
    },
    mounted() {
        this.resGetTaskList();
        this.resGetTaskTable();
    },
    methods: {
        async submitSuccess(row) {
            const data = {
                taskId: row.id,
                type: 2
            };
            const res = await success(data);
            if (res.code === 200) {
                this.$message.success('提交成功');
            } else {
                this.$message.error(res.msg);
            }
            this.resGetTaskList();
            this.resGetTaskTable();
        },
        async submitReturn(row) {
            const data = {
                taskId: row.id,
                type: 1
            };
            const res = await task_return(data);
            if (res.code === 200) {
                this.$message.success('提交成功');
            } else {
                this.$message.error(res.msg);
            }
            this.resGetTaskList();
            this.resGetTaskTable();
        },
        formatCreateTime(createTime) {
            if (!createTime || !Array.isArray(createTime) || createTime.length < 3) {
                return '未知时间';
            }
            return `${createTime[0]}-${createTime[1].toString().padStart(2, '0')}-${createTime[2].toString().padStart(2, '0')}`;
        },

        async resGetTaskList() {
            const res = await getaskList();
            if (res.code === 200) {
                this.taskNameList = res.data;
                console.log(16511);
                console.log(this.taskNameList);
            } else {
                this.$message.error(res.msg);
            }
        },
        async resGetTaskTable() {

            const res = await getTaskTable();
            if (res.code === 200) {
                this.checkTask.checkTaskList = res.data;
            } else {
                this.$message.error(res.msg);
            }

        },


        selectTaskList() {
            // 选择任务列表的逻辑
        },
        async check(row) {
            this.drawer = true;
            this.submit_info = {
                taskName: row.taskName,
                submitTime: this.formatCreateTime(row.submitTime),
                userName: row.userName,
            };

            const res = await getsubmitInfoData(row.id);
            if (res.code === 200) {
                this.submitInfoData = res.data;
                console.log(this.submitInfoData);
            } else {
                this.$message.error(res.msg);
                return; // 处理错误后，提前返回
            }


        }, async downloadFiles() {
            if (!this.submitInfoData.fileIds.length) {
                this.$message.warning('没有可下载的文件');
                return;
            }
            try {
                const data = {
                    fileIds: this.submitInfoData.fileIds,
                    content: this.submitInfoData.content
                };

                const downloadRes = await getDownloadData(data);
                const blob = new Blob([downloadRes], { type: 'application/zip' }); // 创建 Blob
                const url = window.URL.createObjectURL(blob);

                const link = document.createElement('a');
                link.href = url;
                link.setAttribute('download', 'files.zip'); // 设置下载文件名
                document.body.appendChild(link);
                link.click(); // 模拟点击下载
                link.remove(); // 下载后移除链接

                // 释放对象 URL
                window.URL.revokeObjectURL(url);
            } catch (error) {
                console.error('下载错误:', error);
            }
        }, returnTask() {
            // 退回逻辑
        }

    }
}

</script>

<style lang="less" scoped>
.submit_info {
    margin: auto;
    margin-top: 5%;
    width: 90%;
    height: 70%;

}

.contend {
    width: 100%;
    height: 30%;

}

.submit-info-contend {
    font-size: 100%;
    color: #999;
    margin-left: 5%;
}

.submit_info-title {
    color: #666;
    font-size: 120%;

}

.check-submit {
    flex: 1;
    display: flex;
    justify-content: flex-end;
    /* 水平靠右 */
    align-items: flex-end;
    /* 垂直靠底部 */
    padding: 10px;
    /* 可选：内边距 */
}

/deep/.el-drawer__header {
    font-size: 150%;
    color: #000;
}

.info-title {
    display: inline-block;
    margin-bottom: 2%;
    color: #666;
}

.info-submit {
    margin-top: 3%;
    font-size: 110%;
    margin-left: 5%;
    color: #999;
}

.check-task-container {
    width: 98%;
    padding-top: 1%;
    margin: 0 auto;
    background-color: rgb(255, 253, 255);
    border-radius: 40px;
    min-height: 700px;
    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
}

.check-table {
    width: 96%;
    display: flex;
    justify-content: center;
    margin: 0 auto;
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

    margin: 10px auto;
}

.nocheck-num {
    text-align: center;
    color: #999;
}
</style>