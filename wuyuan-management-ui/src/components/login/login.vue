<template>
    <div class="login-container">
        <div class="logo">
            <img src="../../../src/assets/logoblank.png" alt="logo" />
        </div>
        <div class="loginbox">
            <el-form :model="userLogin" :rules="loginRules" ref="userLogin" label-width="80px">
                <el-form-item label="用户名" prop="username">
                    <el-input v-model="userLogin.username" placeholder="用户名"></el-input>
                </el-form-item>
                <el-form-item label="密  码" prop="password" label-width="80px">
                    <el-input v-model="userLogin.password" placeholder="密码" show-password></el-input>
                </el-form-item>
                <div class="user-btn">
                    <el-button type="primary" @click.native="login" :loading="loading" size="mini">登录</el-button>
                    <el-button type="primary" @click.native="register_show = true" size="mini">注册</el-button>
                    <el-button @click="clearLogin" size="mini">重置</el-button>
                </div>
            </el-form>
        </div>
        <div class="register-box">
            <el-dialog title="注册" :visible.sync="register_show" class="register">
                <el-form :model="userRegister" :rules="registerRules" ref="userRegister" label-width="80px"
                    class="demo-ruleForm">
                    <el-form-item label="用户名" prop="username">
                        <el-input v-model="userRegister.username" placeholder="用户名"></el-input>
                    </el-form-item>
                    <el-form-item label="密  码" prop="password">
                        <el-input v-model="userRegister.password" placeholder="密码" show-password></el-input>
                    </el-form-item>
                    <el-form-item label="身份证" prop="idNumer">
                        <el-input v-model="userRegister.idNumer" placeholder="身份证"></el-input>
                    </el-form-item>
                    <el-form-item label="姓  名" prop="name">
                        <el-input v-model="userRegister.name" placeholder="姓名"></el-input>
                    </el-form-item>
                    <el-form-item label="电  话" prop="phone">
                        <el-input v-model="userRegister.phone" placeholder="电话"></el-input>
                    </el-form-item>
                </el-form>
                <div slot="footer" class="dialog-footer">
                    <el-button @click="register_show = false" size="mini">取 消</el-button>
                    <el-button type="primary" @click="register" size="mini">确 定</el-button>
                </div>
            </el-dialog>
        </div>
    </div>
</template>

<script>
import { login, register } from '../../api/login';
import { mapMutations } from 'vuex';

export default {
    data() {
        return {
            register_show: false,
            userLogin: {
                username: '',
                password: ''
            },
            userRegister: {
                username: '',
                password: '',
                idNumer: '',
                name: '',
                phone: ''
            },
            loginRules: {
                username: [
                    { required: true, message: '请输入用户名', trigger: 'blur' },
                    { min: 1, max: 10, message: '长度在 1 到 10个字符', trigger: 'blur' }
                ],
                password: [
                    { required: true, message: '请输入密码', trigger: 'blur' },
                    { min: 6, max: 12, message: '长度在 6 到 12 个字符', trigger: 'blur' }
                ]
            },
            registerRules: {
                username: [
                    { required: true, message: '请输入用户名', trigger: 'blur' },
                    { min: 1, max: 5, message: '长度在 1 到 5个字符', trigger: 'blur' }
                ],
                password: [
                    { required: true, message: '请输入密码', trigger: 'blur' },
                    { min: 6, max: 12, message: '长度在 6 到 12 个字符', trigger: 'blur' }
                ],
                idNumer: [
                    { required: true, message: '请输入身份证号', trigger: 'blur' },
                    { min: 18, max: 18, message: '长度为18位', trigger: 'blur' }
                ],
                name: [
                    { required: true, message: '请输入姓名', trigger: 'blur' },
                    { min: 1, max: 20, message: '长度在 1 到 20 个字符', trigger: 'blur' }
                ],
                phone: [
                    { required: true, message: '请输入电话号码', trigger: 'blur' },
                    { pattern: /^1[3-9]\d{9}$/, message: '请输入有效的电话号码', trigger: 'blur' }
                ]
            },
            loading: false
        };
    },
    methods: {
        ...mapMutations(['changeLogin', 'changeUserName', 'changeID', 'changeimg', 'changePhone']),
        async login() {
            try {
                this.loading = true;
                const valid = await this.$refs.userLogin.validate();
                if (valid) {
                    const response = await login(this.userLogin);
                    console.log(response);
                    if (response.code === 200) {
                        this.$message.success('登录成功');
                        this.updateUserState(response.data);
                        this.$router.push('/api/admin/home/user');
                    } else {
                        this.$message.error(response.msg);
                    }
                }
            } catch (error) {
                console.error('登录失败:', error);
                this.$message.error('登录请求失败，请稍后再试');
            } finally {
                this.loading = false;
            }
        },
        updateUserState(data) {
            console.log(data);
            this.changeLogin({ Authorization: data.token });
            this.changeUserName(data.userName);
            this.changeID(data.id);
            this.changePhone(data.phone);
            this.changeimg(data.img);
        },
        clearLogin() {
            this.$refs.userLogin.resetFields();
        },
        register() {
            this.$refs.userRegister.validate(valid => {
                if (valid) {
                    register(this.userRegister).then(response => {
                        this.$message.success('注册成功');
                        this.register_show = false;
                    }).catch(() => {
                        this.$message.error('注册失败');
                    });
                }
            });
        }
    }
};
</script>

<style scoped>
.login-container {
    background-image: url('/src/assets/image/login.jpg');
    background-size: cover;
    background-position: center;
    height: 100vh;
    /* 填满视口高度 */
    display: flex;
    justify-content: center;
    align-items: center;
    padding: 20px;
    margin: 0;
    /* 去掉默认边距 */
}

.logo img {
    max-width: 80%;
    /* 调整 logo 大小 */
    height: auto;
    margin-bottom: 20px;
    /* logo 和登录框之间的间距 */
}

.loginbox {
    background: rgba(255, 255, 255, 0.9);
    /* 设置背景为白色，略透明 */
    padding: 40px;
    border-radius: 12px;
    /* 更柔和的圆角 */
    box-shadow: 0 4px 20px rgba(0, 0, 0, 0.2);
    /* 增加阴影效果 */
    width: 400px;
    /* 固定宽度 */
}

.el-form-item {
    margin-bottom: 20px;
    /* 表单项之间的间距 */
}

.user-btn {
    display: flex;
    justify-content: flex-end;
    /* 按钮靠右对齐 */
    margin-top: 20px;
    /* 增加顶部间距 */
}

.user-btn el-button {
    margin: 0 2px;
    /* 减小按钮之间的间隔 */
}

.el-button {
    border-radius: 6px;
    /* 统一按钮圆角 */
    background: transparent;
    /* 背景透明 */
    border: 1px solid #b9bdc0;
    /* 边框颜色 */
    color: #6a6c6f;
    /* 字体颜色 */
    transition: all 0.3s;
    /* 添加过渡效果 */
}

.el-button:hover {
    background-color: rgba(95, 100, 106, 0.1);
    /* 悬停时的背景色 */
    transform: translateY(-2px);
    /* 悬停时的提升效果 */
}

.register {
    border-radius: 12px;
    /* 统一圆角 */
    width: 70%;
    /* 对话框宽度 */
    margin: 4% auto;
    /* 上下居中 */
}

.register-box .el-dialog__body {
    background: #ffffff;
    padding: 30px;
    border-radius: 12px;
}

.register-box .el-dialog__header {
    background: #f0f0f0;
    border-bottom: 1px solid #e0e0e0;
    border-radius: 12px 12px 0 0;
    padding: 15px 20px;
    font-size: 20px;
    font-weight: bold;
    text-align: center;
    color: #333;
}

.register-box .el-form-item {
    margin-bottom: 15px;
    /* 调整表单项之间的间距 */
}

.register-box .el-form-item .el-input {
    border-radius: 8px;
    border: 1px solid #dcdfe6;
    transition: border-color 0.3s, box-shadow 0.3s;
    /* 添加过渡效果 */
}

.register-box .el-form-item .el-input:focus {
    border-color: #1e90ff;
    box-shadow: 0 0 5px rgba(30, 144, 255, 0.5);
    /* 聚焦时的阴影效果 */
}

.register-box .dialog-footer {
    display: flex;
    justify-content: flex-end;
    padding-top: 15px;
}

.register-box .dialog-footer el-button {
    margin-left: 10px;
    /* 添加间隔 */
}

.register-box .dialog-footer .el-button {
    background-color: #1e90ff;
    /* 按钮背景色 */
    color: #fff;
    /* 按钮文字颜色 */
}

.register-box .dialog-footer .el-button:hover {
    background-color: #1c86ee;
    /* 悬停时的按钮颜色 */
}

@media (max-width: 768px) {
    .loginbox {
        width: 90%;
        /* 在小屏幕上使用更小的宽度 */
        padding: 20px;
        /* 调整内边距 */
    }
}
</style>