<template>
    <el-container>
        <el-aside width="250px">
            <div>
                <el-menu background-color="#fff" text-color="#353b48" active-text-color="#f1c40f" router
                    :default-active="$route.path" style="
        border:0!important;
">
                    <div class="user">
                        <div class="userHeadshot">
                            <el-avatar shape="square" :size="40" :src="squareUrl"></el-avatar>
                        </div>
                        <span class="username">{{ username }}
                            <el-dropdown>
                                <i class="el-icon-setting" style="transform: translate(20%, 10%);"></i>
                                <el-dropdown-menu slot="dropdown">
                                    <el-dropdown-item @click.native="changePasswordShow = true">更改密码</el-dropdown-item>
                                    <el-dropdown-item @click.native="cancelShow = true">退出登录</el-dropdown-item>
                                </el-dropdown-menu>
                            </el-dropdown>
                        </span>
                    </div>

                    <el-menu-item index="/api/admin/home/user">
                        <template slot="title">
                            <i class="el-icon-user"></i>
                            <span>个人中心</span>
                        </template>
                    </el-menu-item>


                    <el-submenu index="/api/admin/home/team" @click="navigateTo('/api/admin/home/team')">
                        <template slot="title">
                            <i class="el-icon-star-off"></i>
                            <span>团队管理</span>
                        </template>
                        <el-menu-item index="/api/admin/home/team">
                            <i class="el-icon-collection-tag"></i>
                            <span>查看团队</span>
                        </el-menu-item>
                        <el-menu-item index="/api/admin/home/team/createTeam">
                            <i class="el-icon-plus"></i>
                            <span>创建团队</span>
                        </el-menu-item>
                    </el-submenu>
                    <el-submenu index="/api/admin/home/task" @click="navigateTo('/api/admin/home/task')">
                        <template slot="title">
                            <i class="el-icon-folder-opened"></i>
                            <span>任务管理</span>
                        </template>
                        <el-menu-item index="/api/admin/home/task">
                            <i class="el-icon-collection-tag"></i>
                            <span>任务提交</span>
                        </el-menu-item>
                        <el-menu-item index="/api/admin/home/task/checkTask">
                            <i class="el-icon-collection-tag"></i>
                            <span>任务审查</span>
                        </el-menu-item>
                    </el-submenu>

                    <el-menu-item index="/api/admin/home/message">
                        <i class="el-icon-bell"></i>
                        <span slot="title">消息中心</span>
                    </el-menu-item>
                    <el-menu-item index="/api/admin/home/teamUser">
                        <i class="el-icon-setting"></i>
                        <span slot="title">成员管理</span>
                    </el-menu-item>
                </el-menu>
            </div>
        </el-aside>
        <el-container>

            <el-header height="60px">
                <div class="header-content">
                    <div class="logo"><img src="@/assets/logoblack.png"></div>
                    <div class="avatar">
                        <el-avatar shape="square" :size="40" :src="squareUrl">
                        </el-avatar>
                    </div>
                    <div class="outline">
                        <el-button class="outline_button" icon="el-icon-warning-outline" circle
                            @click.native="outlineShow = true"></el-button>
                    </div>

                </div>
            </el-header>

            <el-main class="main">
                <router-view></router-view>
            </el-main>

        </el-container>
        <el-dialog title="确定退出登录？" :visible.sync="cancelShow" width="30%">
            <span slot="footer" class="dialog-footer">
                <el-button @click="cancelShow = false">取 消</el-button>
                <el-button type="primary" @click.native="cancel">确 定</el-button>
            </span>
        </el-dialog>
        <el-dialog title="介绍" :visible.sync="outlineShow" width="50%">
            <div>
                <h3>
                    子胥任务管理系统：协作与管理的新篇章
                </h3>
                <span>
                    随着互联网技术的发展以及远程工作模式的日益普及，团队合作的方式也在不断进化。为了更好地适应这种变化，“子胥任务管理系统”应运而生。作为一个全新的在线协作平台，它不仅为用户提供了一个便捷的任务管理工具，同时也创造了一个开放共享的工作环境。
                </span>
                <h3>
                    团队组建：从一个人到一群人
                </h3>
                <span>在子胥任务管理系统中，任何人都可以成为发起者，创建自己的团队。无论是组织一场线上会议、策划一次市场活动，还是共同完成一个软件开发项目，只需要简单的几步操作就能建立一个专属团队空间。这里没有门槛，只有无限的可能性。</span>
                <h3>
                    角色分配：明确职责，各司其职
                </h3>
                <span>
                    每个团队都需要有一个核心领导者来指引方向，因此，在子胥系统里，每个团队都有明确的组长。组长拥有发布任务、分配工作以及调整团队结构的权利。同时，组内成员可以根据自身能力和兴趣选择适合自己的角色，确保每个人都能在最适合的位置上发挥最大的价值。
                </span>
                <h3>
                    任务管理：透明高效的工作流程
                </h3>

                <span>组长可以利用系统内置的功能轻松地创建任务，并指派给特定的团队成员。每个任务的状态（如待办、进行中、已完成）一目了然，方便所有人随时跟进项目进度。此外，系统还支持任务评论和文件共享，促进了信息的快速流通与协同编辑。</span>

                <h3>成就激励：让贡献看得见</h3>

                <span>
                    为了鼓励团队成员积极参与，子胥系统设计了一套完善的成就体系。每当完成一项任务或达到特定里程碑时，用户都会获得相应的奖励积分。这些积分不仅是对个人努力的认可，也是晋升团队地位、获取更多权限的基础。
                </span>
                <br>
                <span>
                    总之，子胥任务管理系统以其灵活多变的团队组建方式、清晰明了的角色分配机制、高效透明的任务管理模式以及激励人心的成就体系，正在成为越来越多企业和个人选择的合作平台。不论您是想要寻找志同道合的朋友共同完成梦想，还是希望提高工作效率的企业管理者，子胥都能为您提供最佳解决方案。
                </span>
            </div>
            <span slot="footer" class="dialog-footer">
                <el-button @click="outlineShow = false">取 消</el-button>
                <el-button type="primary" @click="outlineShow = false">确 定</el-button>
            </span>
        </el-dialog>
        <el-dialog title="是否要更换密码" :visible.sync="changePasswordShow" width="width">
            <div>
                <el-form ref="userPassword" :model="userPassword" :rules="rules" label-width="120px">
                    <el-form-item label="旧密码" prop="oldPassword">
                        <el-input type="password" v-model="userPassword.oldPassword" auto-complete="off"></el-input>
                    </el-form-item>
                    <el-form-item label="新密码" prop="newPassword">
                        <el-input type="password" v-model="userPassword.newPassword" auto-complete="off"></el-input>
                    </el-form-item>

                </el-form>
            </div>
            <div slot="footer">
                <el-button @click.native="changePasswordShowFalse">取 消</el-button>
                <el-button type="primary" @click.native="changePasswordShowTrue">确 定</el-button>
            </div>
        </el-dialog>

    </el-container>
</template>

<script>
import { mapState, mapMutations } from 'vuex';

import { changePassword } from '@/api/home/user';

const options = {
    data() {
        return {
            userPassword:
            {
                oldPassword: '',
                newPassword: ''
            },
            outlineShow: false,
            changeHeadshot: false,
            cancelShow: false,
            changePasswordShow: false,
            squareUrl: require("@/" + this.$store.state.img),
            rules: {
                oldPasswordRules: [
                    { required: true, message: '请输入旧密码', trigger: 'blur' },
                    { min: 6, max: 15, message: '长度在 6 到 15 个字符', trigger: 'blur' }
                ],
                newPasswordRules: [
                    { required: true, message: '请输入新密码', trigger: 'blur' },
                    { min: 6, max: 15, message: '长度在 6 到 15 个字符', trigger: 'blur' }
                ]
            }
        };
    },
    mounted() {
        this.updateBaseUser();

    },
    computed: {
        ...mapState(['username', 'img', 'id'])
    },
    methods: {
        ...mapMutations(['changeLogin', 'changeImg', 'changeUserName', 'changeID']),
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

        changePasswordShowFalse() {
            this.changePasswordShow = false;
            this.$refs.userpasswor.resetFields();
        },
        changePasswordShowTrue() {
            console.log(this.userPassword);
            this.changePasswordShow = false;
            this.$refs.userPassword.validate(valid => {
                if (valid) {
                    const updatedData = {
                        id: this.$store.state.id,
                        oldPassword: this.userPassword.oldPassword,
                        newPassword: this.userPassword.newPassword
                    };
                    changePassword(updatedData).then(res => {
                        console.log(res);
                        if (res.code === 200) {
                            this.$message({
                                message: '修改成功',
                                type: 'success'
                            });

                        } else {
                            this.$message({
                                message: res.msg,
                                type: 'error'
                            });
                        }
                    })
                } else {
                    this.$message({
                        message: '请输入正确密码',
                        type: 'error'
                    });
                }
            })

        },
        updateBaseUser() {

            if (this.img) {
                console.log(this.img)
                this.squareUrl = require(`@/${this.img}`)
            }
        },
        async cancel() {
            localStorage.clear(); // 清除所有本地存储内容
            this.$router.push({ name: 'login' })

        }
    }



}
export default options;
</script>


<style lang="less" scoped>
.main {
    background-color: #f6f7fb;
}

.el-container {

    height: 100%;
    width: 100%;
}

.el-aside {
    background-color: #fff;
    height: 100%;

}

.userHeadshot {
    padding: 5%
}

.outline_button {
    max-height: 5px;
    max-width: 5px;
    // 设置中间的图标位置使居中
    display: flex;
    justify-content: center;
    align-items: center;

}


.el-dropdown {
    margin-left: 40px;
}


.user {
    background-color: #f6f7fb;
    width: 100%;
    height: 60px;
    box-shadow: 0 20px 30px #353b48;
}

.header-content {
    width: 100%;
    float: left;
}

.outline {
    float: right;
    margin: 1% 1% 0 0;
}

.logo {
    float: left;
}

.logo img {
    width: 40%;
}

.avatar {
    float: right;
    margin-top: 0.6%;
}

.username {
    position: absolute;
    top: 20px;
    left: 80px;
    color: #353b48;

}
</style>