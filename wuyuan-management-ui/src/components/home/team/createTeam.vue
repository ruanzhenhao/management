<template>
    <div class="create-team">
        <h1 class="create-title">创建团队</h1>
        <div class="create-content">
            <el-form ref="createTeamForm" :model="createTeamForm" :rules="rules" label-width="150px">
                <el-form-item label="团队名称" prop="teamName">
                    <el-input v-model="createTeamForm.teamName" class="teamNameInput"></el-input>
                </el-form-item>
                <el-form-item label="邀请用户">
                    <div class="user-input">
                        <el-input v-model="invitationUser" placeholder="请输入邀请的用户名" @keydown.enter.native="addUser()"
                            class="invitation-input"></el-input>
                        <el-button type="primary" @click="addUser" class="action-button">确定</el-button>
                    </div>
                </el-form-item>
                <el-form-item label="已邀请用户" v-if="invitedUsers.length > 0">
                    <div class="invited-users">
                        <el-tag type="info" v-for="(user, index) in invitedUsers" :key="index" closable
                            @close="removeUser(index)">
                            {{ user }}
                        </el-tag>
                    </div>
                </el-form-item>
                <el-form-item label="邀请码有效期" prop="validityTime">
                    <el-date-picker v-model="createTeamForm.validityTime" type="date" placeholder="选择未来日期"
                        value-format="yyyy-MM-dd">
                    </el-date-picker>
                </el-form-item>
                <el-form-item label="团队介绍" prop="introduction">
                    <el-input v-model="createTeamForm.introduction" type="textarea" :rows="15" placeholder="请输入团队介绍"
                        class="textarea-input" maxlength="100" resize='none'></el-input>
                    <span class="char-count">{{ charCount }}/100</span>
                </el-form-item>
                <el-form-item class="button-group">
                    <el-button type="primary" @click="submitForm" class="action-button">提交信息</el-button>
                </el-form-item>
            </el-form>
            <el-dialog title="创建团队成功" :visible.sync="victory" width="30%">
                <div slot="footer">
                    <el-button type="primary" @click="getInvitation" class="action-button">生成邀请码</el-button>
                    <el-button type="primary" @click="victory = false" class="action-button">关闭</el-button>
                </div>
            </el-dialog>

        </div>
    </div>
</template>

<script>
import { addTeam, selectUser } from '@/api/team';
export default {
    data() {
        return {
            victory: false,
            invitationUser: '',
            invitedUsers: [],
            createTeamForm: {
                teamName: '',
                introduction: '',
                validityTime: null,
            },
            invitationCode: null,
            rules: {
                teamName: [
                    { required: true, message: '团队名称不能为空', trigger: 'blur' },
                    { min: 3, max: 20, message: '团队名称长度应在 3 到 20 个字符之间', trigger: 'blur' }
                ],
                introduction: [
                    { required: true, message: '团队介绍不能为空', trigger: 'blur' },
                    { max: 250, message: '团队介绍不能超过 250 个字符', trigger: 'blur' }
                ],
                validityTime: [
                    { required: true, message: '请选择邀请码有效期', trigger: 'change' },
                    { validator: this.validateFutureDate, trigger: 'change' }
                ],
            }
        };
    },
    computed: {
        charCount() {
            return this.createTeamForm.introduction.length;
        },
    },
    methods: {
        validateFutureDate(rule, value, callback) {
            const today = new Date();
            today.setHours(0, 0, 0, 0); // 设置时间为今天的开始
            if (!value) {
                return callback(new Error('请选择邀请码有效期'));
            }
            if (new Date(value) < today) {
                callback(new Error('邀请码有效期必须是未来的日期'));
            } else {
                callback();
            }
        },
        getInvitation() {
            navigator.clipboard.writeText(this.invitationCode).then(() => {
                this.$message.success('邀请码已复制到剪贴板');
            }).catch(() => {
                this.$message.error('复制失败');
            });
        },
        async addUser() {
            if (!this.invitationUser) {
                this.$message.error('请输入用户名');
                return;
            }
            const res = await selectUser(this.invitationUser);
            if (res.code === 200) {
                this.invitedUsers.push(this.invitationUser);
                this.invitationUser = ''; // 清空输入框
            } else {
                this.$message.error(res.msg);
            }
        },
        removeUser(index) {
            this.invitedUsers.splice(index, 1);
        },
        async submitForm() {
            this.$refs.createTeamForm.validate(async (valid) => {
                if (valid) {
                    console.log('提交的信息:', this.createTeamForm, '邀请的用户:', this.invitedUsers);
                    const data = {
                        teamName: this.createTeamForm.teamName,
                        introduction: this.createTeamForm.introduction,
                        validityTime: this.createTeamForm.validityTime,
                        invitedUsers: this.invitedUsers
                    };
                    console.log(data);
                    const req = await addTeam(data);

                    if (req.code === 200) {
                        this.$message.success('创建成功');
                        this.invitationCode = req.data
                        this.victory = true;
                        this.createTeamForm = {
                            teamName: '',
                            introduction: '',
                            validityTime: null,
                        };

                    } else {
                        this.$message.error(req.msg);
                    }

                } else {
                    this.$message.error('请修正表单中的错误');
                }
            });
        }
    }
}
</script>

<style scoped>
.create-team {
    padding: 20px;
    border-radius: 8px;
    width: 97%;
    height: 95%;
    box-shadow: 0 5px 10px rgba(0, 0, 0, 0.1);

}

.create-title {
    margin-left: 10px;
    font-size: 32px;
    margin-bottom: 20px;
    color: #333;
}

.button-group {
    margin-top: 60px;
}

.create-content {
    background-color: #fff;
    padding: 20px;
    border-radius: 8px;
    box-shadow: 0 1px 5px rgba(0, 0, 0, 0.1);
}

.el-form-item {
    margin-bottom: 15px;
}

.teamNameInput {
    width: 300px;
}

.textarea-input {
    width: 600px;
}

.invitation-input {
    width: 300px;
    margin-right: 10px;
}

.user-input {
    display: flex;
    align-items: center;
}

.invited-users {
    margin-top: 10px;
}

.el-tag {
    margin-right: 5px;
}

.action-button {
    background-color: #353b48;
    color: #fff;
    border: none;
}

.action-button:hover {
    background-color: #e4e2d9;
}

.char-count {
    font-size: 12px;
    color: #888;
    margin-top: 5px;
}
</style>