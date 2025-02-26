<template>
    <div class="submitTask">
        <div class="submit-container">
            <div class="submit-form">
                <div class="form">
                    <h3 class="title-name">提交任务</h3>
                    <h4>正文</h4>
                    <textarea v-model="submitTaskForm.text" placeholder="请输入任务内容" class="fixed-size-input"></textarea>
                    <h4>附件 <i class="el-icon-upload2"></i></h4>
                    <el-upload class="upload-demo" action="#" :on-preview="handlePreview" :on-remove="handleRemove"
                        :before-remove="beforeRemove" multiple :limit="3" :on-exceed="handleExceed"
                        :file-list="submitTaskForm.fileList" :auto-upload="false" :on-change="handleChange">
                        <el-button size="small" type="primary">点击选择文件</el-button>
                        <div slot="tip" class="el-upload__tip">只能上传 jpg/png 文件，且不超过 500kb</div>
                    </el-upload>
                    <el-button class="submit-button" @click="submitForm">提交任务</el-button>
                </div>
            </div>
            <div class="misstion-info">
                <div class="back">
                    <el-button icon="el-icon-back" @click="back" circle></el-button>
                </div>
                <div class="misstion-name">
                    <h2>{{ taskInfo.taskName }}</h2>
                    <span class="publisher">{{ taskInfo.createUser }}</span><br><br>
                    <span class="submission-date">{{ formatCreateTime(taskInfo.createTime) }}__{{
                        formatCreateTime(taskInfo.endTime) }}</span>
                </div>
                <div class="demand">
                    <h2>要求:</h2>
                    <p class="text">{{ taskInfo.demand }}</p>
                </div>
            </div>
        </div>
        <el-dialog :visible.sync="dialogVisible">
            <img width="100%" :src="dialogImageUrl" alt="">
        </el-dialog>
    </div>
</template>

<script>
import { getTaskInfo, submitMission, uploadFile } from '@/api/task';
import { mapState } from 'vuex';

export default {
    mounted() {
        this.getTask();
    },
    computed: {
        ...mapState(['taskId'])
    },
    data() {
        return {
            submitTaskForm: {
                text: '',
                fileList: [],
                fileListInfo: [] // 存储文件列表
            },
            taskInfo: {},
            dialogImageUrl: '',
            dialogVisible: false,
            loading: false,

        };
    },
    methods: {


        handleChange(file, fileList) {
            this.submitTaskForm.fileList = fileList; // 更新 fileList
            console.log(this.submitTaskForm);
        },

        async upload() {
            const formData = new FormData();

            // 将每个文件添加到 FormData
            this.submitTaskForm.fileList.forEach(file => {
                formData.append('fileList', file.raw); // 使用 raw 属性以获取实际文件
            });

            // 发送请求
            const res = await uploadFile(formData);
            if (res.code === 200) {
                console.log(res.data);
                this.submitTaskForm.fileListInfo = res.data;
                console.log(this.submitTaskForm.fileListInfo);
                this.$message.success('文件上传成功');
            } else {
                this.$message.error('文件上传失败');
            }

        },


        async submitForm() {
            this.upload();
            console.log(this.submitTaskForm);


            const data = {
                TeamId: 10086,
                taskId: this.taskId,
                text: this.submitTaskForm.text,
                files: this.submitTaskForm.fileListInfo
            };


            console.log(data);
            try {
                const res = await submitMission(data);
                if (res.code === 200) {
                    this.$message.success('提交成功');
                    this.$router.push('/api/admin/home/task');
                } else {
                    this.$message.error(res.msg);
                }
            } catch (error) {
                console.error('提交任务时出错:', error);
                this.$message.error('提交失败，请重试');
            }
        },

        beforeRemove(file, fileList) {
            return this.$confirm(`确定移除 ${file.name}？`).then(() => {
                fileList = this.submitTaskForm.fileList.filter(f => f.uid !== file.uid);

                this.$message.success(`${file.name} 已被移除`);

                console.log(this.submitTaskForm.fileList);
            }).catch(() => {
                // 用户取消删除
                this.$message.info(`${file.name} 保持不变`);
            });
        },

        formatCreateTime(createTime) {
            if (!createTime || !Array.isArray(createTime) || createTime.length < 3) {
                return '未知时间';
            }
            return `${createTime[0]}-${createTime[1].toString().padStart(2, '0')}-${createTime[2].toString().padStart(2, '0')}`;
        },

        async getTask() {
            const res = await getTaskInfo(this.taskId);
            if (res.code === 200) {
                this.taskInfo = res.data;
            } else {
                this.$message.error(res.msg);
            }
        },

        back() {
            this.$router.push('/api/admin/home/task');
        },

        handleRemove(file, fileList) {
            console.log(file, fileList);
        },

        handlePreview(file) {
            console.log(file);
        },

        handleExceed(files, fileList) {
            this.$message.warning(`当前限制选择 3 个文件，本次选择了 ${files.length} 个文件，共选择了 ${files.length + fileList.length} 个文件`);
        }
    }
}
</script>



<style scoped>
.back {
    width: 5%;
    height: 5%;
    padding-left: 90%;
}

.text {
    word-wrap: break-word;
    overflow-wrap: break-word;
    line-height: 1.5;
    font: 1.5em;
    color: #999;
    margin-top: 0.5em;
}

.button-back {
    color: #000;
    font-size: 1.125em;
    margin-bottom: 0;


}

.styled-form {
    width: 100%;
}

.input-label {
    margin-left: 6%;
    font-size: 1.5em;
    margin-bottom: 0em;
    color: #999;
}

.fixed-size-input {
    width: 100%;
    /* 设置宽度为100%，或者可以设置具体的像素值 */
    max-width: 380px;
    /* 最大宽度 */
    height: 120px;
    /* 固定高度 */
    resize: none !important;
    /* 禁止用户手动调整大小 */
    border-radius: 5px;
    border: 1px solid #dcdcdc;
    /* 边框颜色 */
    /* 圆角 */

    padding: 10px;
    /* 内边距 */
}

.fixed-size-input:focus {
    border-color: #409eff;
    /* 聚焦时的边框颜色 */
    box-shadow: 0 0 5px rgba(64, 158, 255, 0.5);
    /* 聚焦时的阴影效果 */
}

.action-button {
    margin-top: 20%;
    width: 90%;
    margin-left: 5%;
}

.styled-input {
    border-radius: 5px;
    padding-left: 5%;
    width: 80%;

    transition: border-color 0.3s ease;
    margin: 0 auto
}

.styled-input:focus {
    border-color: #409eff;
    /* 聚焦时的边框颜色 */
    box-shadow: 0 0 5px rgba(64, 158, 255, 0.5);
    /* 聚焦时的阴影效果 */
}

.upload-area {
    border-radius: 5px;
    padding-left: 0em;

    transition: border-color 0.3s ease;
}

.upload-area:hover {
    border-color: #409eff;
    /* 鼠标悬停时的边框颜色 */
}

.el-upload-list__item-thumbnail {
    width: 100px;
    height: 100px;
    object-fit: cover;
    border-radius: 5px;
    margin-top: 0.5em;
}

.submitTask {
    width: 100%;
    min-width: 1600px;
    max-height: 600px;
    height: 90%;
}

.submit-container {
    display: flex;
    /* 使用 Flexbox 布局 */
    margin: 1% auto;
    border-radius: 30px;
    width: 95%;
    min-width: 1500px;
    background-color: rgb(255, 255, 255);
    height: 60%;
    min-height: 700px;
    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
    /* 添加阴影 */
}

.misstion-info {
    width: 30%;
    /* 30% 宽度 */
    padding: 2%;
    /* 增加内边距 */
    display: flex;
    flex-direction: column;
    /* 垂直排列子元素 */
}

.misstion-name {
    font-size: 1.5em;
    /* 适当调整任务名字体大小 */
    font-weight: bold;
    /* 加粗 */
    color: #333;
    /* 颜色 */
    margin-bottom: 1em;
    /* 下边距 */
}



.demand {
    font-size: 1.2em;
}

.form {
    position: relative;
    margin-left: 10%;
    padding: 20px;
    width: 90%;
    max-width: 400px;
    height: auto;
    min-height: 600px;
    border-radius: 0 0 20px 20px;
    background-color: rgba(255, 255, 255, 0.9);
    /* 浅色背景 */
    box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
    /* 更柔和的阴影 */
    transition: transform 0.3s ease;
    overflow: hidden;
    /* 确保圆角不受影响 */
    /* 平滑的悬停效果 */
}

.form:hover {
    transform: translateY(-2px);

    /* 悬停时的抬升效果 */
}

.form::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background-color: rgba(249, 249, 249, 0.8);
    /* 半透明背景 */
    backdrop-filter: blur(10px);
    /* 模糊效果 */

    z-index: -1;
    /* 确保伪元素在下面 */
}

h4 {
    font-size: 1.2em;
    color: #666;
    /* 较浅的灰色 */
    margin-top: 1.5em;
    /* 上边距 */
}

.form .content {
    position: relative;
    /* 确保内容在伪元素之上 */
    z-index: 1;
    /* 置于上层 */
}

.el-input,
.el-upload {
    margin-bottom: 1.5em;
    /* 增加输入框和上传区域的下边距 */
}

.submit-button {
    position: absolute;
    /* 绝对定位 */
    bottom: 10%;
    /* 距离底部的距离 */
    left: 50%;
    transform: translateX(-50%);
    /* 水平居中 */
    width: calc(100% - 40px);
    /* 按钮宽度，并考虑左右边距 */
    background-color: #409eff;
    /* 按钮背景色 */
    color: white;
    /* 按钮文字颜色 */
    border-radius: 5px;
    /* 圆角 */
    transition: background-color 0.3s;
    /* 悬停效果 */
}

.submit-button:hover {
    background-color: #66b1ff;
    /* 悬停时按钮颜色 */
}

.submission-date {
    font-size: 0.9em;
    /* 发布者和提交时间的字体大小 */
    color: #555;
    /* 较浅的灰色 */

    /* 适当的下边距 */
}

.demand h2 {
    font-size: 1.2em;
    /* 任务要求标题的字体大小 */
    color: #444;
    /* 较深的灰色 */
}



.submit-form {
    width: 70%;
    /* 70% 宽度 */
    background-color: #f9f9f9;
    background-image: url('@/assets/image/background-img.jpg');
    /* 示例背景颜色 */
    border-left: 1px solid #e0e0e0;
    /* 左边框 */
}
</style>
