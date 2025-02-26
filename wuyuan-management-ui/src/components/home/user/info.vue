<template>
    <div class="info-container">
        <el-breadcrumb separator="/">
            <el-breadcrumb-item :to="{ path: '/api/admin/home/user' }">首页</el-breadcrumb-item>
            <el-breadcrumb-item>个人信息</el-breadcrumb-item>
        </el-breadcrumb>
        <div class="user-card">
            <div class="header">
                <el-button class="edit-button" icon="el-icon-edit" circle @click.native="editProfile"></el-button>
                <div class="background">
                    <div class="block">
                        <el-avatar shape="circle" :size="120" :src="squareUrl"></el-avatar>
                    </div>
                </div>
            </div>
            <div class="content">
                <div class="user-info">
                    <div class="info-item" v-for="(value, label) in userDetails" :key="label">
                        <span class="label">{{ label }}:</span>
                        <span class="value">{{ value }}</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
import { getUser } from '@/api/home/user'

export default {
    data() {
        return {
            userDetail: {},
            squareUrl: ''
        }
    },
    computed: {
        formattedUpdateTime() {
            if (!this.userDetail.updateTime || !Array.isArray(this.userDetail.updateTime)) {
                return '';
            }
            const date = new Date(...this.userDetail.updateTime);
            return date.toLocaleString();
        },
        userDetails() {
            return {
                '用户名': this.userDetail.username,
                '姓名': this.userDetail.name,
                '性别': this.userDetail.sex,
                '电话': this.userDetail.phone,
                '身份证号': this.userDetail.idNumber,
                '邮箱': this.userDetail.email,
                '爱好': this.userDetail.hobby,
                '更新时间': this.formattedUpdateTime
            };
        }
    },
    methods: {
        async getUser() {
            const res = await getUser(this.$store.state.id);
            if (res.code === 200) {
                this.userDetail = res.data;
                this.squareUrl = require(`@/${this.userDetail.img}`);
            } else {
                this.$message({ message: res.msg, type: 'error' });
            }
        },
        editProfile() {
            this.$router.push('/api/admin/home/user/info/editor');
        }
    },
    mounted() {
        this.getUser();
    }
}
</script>

<style lang="less" scoped>
.info-container {
    width: 95%;
    height: 90%;
    padding: 2%;
}

.user-card {
    background-color: #fff;
    border-radius: 10px;
    box-shadow: 0 2px 12px rgba(0, 0, 0, 0.1);
    margin-top: 20px;
}

.header {
    position: relative;
    height: 200px;
    border-radius: 10px 10px 0 0;
    background-image: url('/src/assets/image/login.jpg');
    background-size: cover;
    background-position: center;

    .edit-button {
        position: absolute;
        top: 10px;
        right: 10px;
        z-index: 2;
    }

    &::after {
        content: '';
        position: absolute;
        bottom: 0;
        left: 0;
        width: 100%;
        height: 50%;
        background: linear-gradient(0deg, rgba(0, 0, 0, 0.5) 0%, rgba(0, 0, 0, 0) 100%);
        z-index: 1;
    }

    .block {
        position: absolute;
        bottom: -50px;
        left: 50%;
        transform: translateX(-50%);
        z-index: 2;
    }
}

.content {
    padding: 30px;

    .user-info {
        .info-item {
            display: flex;
            justify-content: space-between;
            margin-bottom: 20px;
            font-size: 18px;

            .label {
                color: #555;
                font-weight: bold;
            }

            .value {
                color: #333;
            }
        }
    }
}
</style>