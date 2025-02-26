<template>
    <div class="main">
        <div class="userdata">
            <div class="block">
                <el-avatar :size="130" :src="circleUrl" class="circle"></el-avatar>
                <el-button icon="el-icon-camera-solid" circle class="headshot"
                    @click.native="changeHeadshot = true"></el-button>
            </div>
            <div class="user">
                <span class="name">{{ this.$store.state.username }}</span>
                <br />
                <span class="phone">phone :{{ this.$store.state.phone }}</span>
            </div>

            <div class="button">
                <el-button round class="details" @click.native="userDetail">
                    <i class="el-icon-user-solid"></i>
                    <span class="userDeta">个人信息</span>
                </el-button>
            </div>
            <div class="button-message">
                <el-button round class="details" @click.native="message">
                    <i class="el-icon-s-comment"></i>
                    <span class="userDeta">消息提醒</span>
                </el-button>
            </div>
            <div class="button-message">
                <el-button round class="details" @click.native="task">
                    <i class="el-icon-s-order"></i>
                    <span class="userDeta">未做任务</span>
                </el-button>
            </div>
        </div>
        <div class="taskData">
            <taskData></taskData>
        </div>
        <div>
            <el-dialog title="更换头像" native=true :visible.sync="changeHeadshot" width='30%'>
                <div>
                    <el-scrollbar>
                        <el-row :gutter="20" class="img-row">
                            <el-col class="img-col" :xs="8" :sm="6" :md="4" :lg="4" :xl="3" v-for="item in imageUrls"
                                :key="item.id">
                                <el-avatar :size="50" :src="require('@/' + item.url)"
                                    :class="{ 'selected': item.selected }"
                                    @click.native="selectAvatar(item)"></el-avatar>
                            </el-col>
                        </el-row>
                    </el-scrollbar>
                </div>
                <div slot="footer">
                    <el-button @click="changeHeadshot = false">取 消</el-button>
                    <el-button type="primary" @click.native="changeFormHeadshot">确 定</el-button>
                </div>
            </el-dialog>
        </div>
    </div>
</template>

<script>
import { updateHeadshot } from '@/api/home/user'
import taskData from './taskData.vue'


const options = {
    components: { taskData },
    data() {
        return {
            newHeadshot: '',
            changeHeadshot: false,
            imageUrls: [
                { id: 2, url: 'assets/headshot/type2.jpg', selected: false },
                { id: 3, url: 'assets/headshot/type3.jpg', selected: false },
                { id: 4, url: 'assets/headshot/type4.jpg', selected: false },
                { id: 5, url: 'assets/headshot/type5.jpg', selected: false },
                { id: 6, url: 'assets/headshot/type6.jpg', selected: false },
                { id: 7, url: 'assets/headshot/type7.jpg', selected: false },
                { id: 8, url: 'assets/headshot/type8.jpg', selected: false },
                { id: 9, url: 'assets/headshot/type9.jpg', selected: false },
                { id: 10, url: 'assets/headshot/type10.jpg', selected: false },
                { id: 11, url: 'assets/headshot/type11.jpg', selected: false }
            ],
            circleUrl: require("@/" + this.$store.state.img)
        }
    },
    methods: {
        selectAvatar(item) {
            if (item.selected) {
                console.log('取消选中');
                item.selected = false;
                this.newHeadshot = '';
            } else {
                this.imageUrls.forEach(img => {
                    img.selected = false;
                });
                item.selected = true;
                this.newHeadshot = item.url;
                console.log('选中头像：' + item.url);
            }
        },
        changeFormHeadshot() {
            this.changeHeadshot = false;
            if (this.newHeadshot) {
                const updatedData = {
                    id: this.$store.state.id,
                    img: this.newHeadshot
                };
                updateHeadshot(updatedData).then(res => {
                    console.log(res);
                });
                this.$store.commit('changeimg', this.newHeadshot);
                this.$message({
                    message: '更换成功',
                    type: 'success'
                });
            } else {
                this.$message({
                    message: '更换失败',
                    type: 'error'
                });
            }
        },
        task() {
            this.$router.push("/api/admin/home/task")
        },
        message() {
            this.$router.push({ name: 'message' })
        },
        userDetail() {
            this.$router.push({ name: 'info' })
        }
    }
}
export default options
</script>

<style lang="less" scoped>
.block {
    transform: translate(0%, 30%);
    text-align: center;
}

.headshot {
    position: fixed;
    margin: -6% 0 0 54%;
    max-height: 30%;
    max-width: 30%;
    display: flex;
    justify-content: center;
    align-items: center;
}

.userdata {
    margin-top: 1.35%;
    float: left;
    height: 95.7%;
    width: 40%;
    background-color: #fff;
    border-radius: 30px;
    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
    margin-right: 30px;
}

.taskData {
    margin-top: 1.35%;
    float: left;
    height: 91%;
    width: 55%;
    background-color: #ffffff;
    border-radius: 30px;
}

.main {
    width: 100%;
    height: 100%;

}

.img-row {
    margin: 0;
    padding: 0;
}

.img-col {
    margin: 5px;
    padding: 5px;
}

.selected {
    border: 2px solid #409EFF !important;
    box-shadow: 0 0 10px rgba(64, 158, 255, 0.5) !important;
}

.button {
    font-size: 25px;
    margin-top: 15%;
    text-align: center;
}

.button-message {
    margin-top: 10%;
    text-align: center;
}

.user {
    text-align: center;
    margin-top: 10%;
}

.details {
    font-size: 18px;
    width: 85%;
    height: 100px;
    background-color: #f5f5f5; // 按钮背景色
    color: rgb(0, 0, 0); // 按钮字体颜色
    border: none; // 去掉边框
    border-radius: 30px; // 圆角
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1); // 添加阴影
    cursor: pointer; // 鼠标悬停时显示为手形
    transition: background-color 0.3s, transform 0.2s; // 添加过渡效果
}

// 悬停效果
.details:hover {
    background-color: #f0f0f0; // 悬停时背景色变化
    transform: translateY(-2px); // 悬停时微微抬起
}

// 点击效果
.details:active {
    transform: translateY(0); // 点击时返回原位
}

.name {
    font-size: 27px;
    font-weight: bold;
}

.phone {
    transform: translateY(-30px);
    font-size: 13px;
    color: #999;
}
</style>