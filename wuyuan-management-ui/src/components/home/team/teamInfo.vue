<template>
    <div class="team-container">

        <el-button type="text" class="button-back" @click.native="back">
            <i class="el-icon-arrow-left"></i> 返回
        </el-button>
        <div class="flex-container">
            <div class="team-group">
                <div class="team-report">
                    <div class="task-select">
                        <el-select v-model="task_id" placeholder="选择任务" @change="changeTask" size="small"
                            class="custom-select inputDeep">
                            <el-option v-for="task in taskOptions" :key="task.taskId" :label="task.taskName"
                                :value="task.taskId" />
                        </el-select>
                    </div>
                    <div class="report-header">
                        <div class="top10">
                            <top10></top10>
                        </div>
                        <div class="task-complete">
                            <completementTask></completementTask>
                        </div>
                    </div>
                </div>
                <div class="list-group">
                    <div class="team-users">
                        <h1 class="list-title">Team User List</h1>
                        <div class="user-list">
                            <div class="user-card" v-for="user in users" :key="user.id">
                                <el-avatar :src="require('@/' + user.img)" class="user-avatar" shape="square" />
                                <div class="user-name">{{ user.userName }}</div>
                            </div>
                        </div>
                    </div>
                    <div class="team-task">
                        <h1 class="list-title">Task List <i class="el-icon-edit-outline" @click="createTask"
                                @mouseover="hovered = true" @mouseleave="hovered = false"
                                :class="{ 'hovered': hovered }"></i></h1>
                        <div class="task-list">
                            <div v-for="task in tasks" :key="task.id" class="task-item">
                                <div class="task-header">
                                    <span class="task-name">{{ task.taskName }}</span>
                                    <span class="task-status" :class="getStatusClass(task.status)">
                                        {{ getStatusText(task.status) }}
                                    </span>
                                </div>
                                <div class="task-content">{{ task.demand }}</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="my-team">

                <h1 class="title">My Team</h1>
                <div class="team-name">
                    <h1 class="name">{{ name }}</h1>
                    <div class="set">
                        <h1 class="set_title">团队管理</h1>
                        <div class="set-group">
                            <div class="set_div">
                                <el-button type="primary" class="responsive-button"
                                    @click="updateTeamNameShow = true">更改群名 <i class="el-icon-more"></i></el-button>
                            </div>
                            <div class="set_div">
                                <el-button type="primary" class="responsive-button"
                                    @click="managementTeamUserShow = true">管理成员
                                    <i class="el-icon-set-up"></i></el-button>
                            </div>
                            <div class="set_div">
                                <el-button type="primary" class="responsive-button"
                                    @click="invitationUserShow = true">邀请成员 <i class="el-icon-user"></i></el-button>
                            </div>
                            <div class="set_div">
                                <el-button type="primary" class="responsive-button" @click="quitTeamShow = true">退出团队 <i
                                        class="el-icon-setting"></i></el-button>
                            </div>
                            <div class="set_div">
                                <el-button type="primary" class="responsive-button" @click="getInvitation">获取邀请码 <i
                                        class="el-icon-s-claim"></i></el-button>
                            </div>
                            <div class="set_div">
                                <el-button type="primary" class="responsive-button" @click="deleteTeamShow = true">解散团队
                                    <i class="el-icon-error"></i></el-button>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="spacing"></div> <!-- 增加间隔 -->
                <div class="team-introduction">
                    <h1 class="title-introduction">团队简介 <i class="el-icon-more"
                            @click="showChangeIroduction = true"></i>
                    </h1>
                    <span class="introduction">{{ introduction }}</span>
                </div>
                <div class="team-user-group">
                    <div class="male-female-percentage">
                        <maleFemalePercentage></maleFemalePercentage>
                    </div>
                    <div class="no-task-percentage">
                        <noTaskPercentage></noTaskPercentage>
                    </div>
                </div>
            </div>
        </div>
        <el-dialog title="团队简介" :visible.sync="showChangeIroduction" width="40%">
            <div>
                <el-input type="textarea" v-model="introduction" placeholder="请输入团队简介"></el-input>
            </div>
            <span slot="footer" class="dialog-footer">
                <el-button @click="showChangeIroduction = false">取 消</el-button>
                <el-button type="primary" @click.native="changeIntroduction">确定修改</el-button>
            </span>
        </el-dialog>

        <el-dialog title="请选择新组长" :visible.sync="userShow" width="45%">
            <div class="dialog-team-users">
                <div class="dialog-user-list">
                    <div class="dialog-user-card" v-for="user in userAndRole.adminVOList" :key="user.id"
                        :class="{ selected: selectedBossID === user.id }" @click="selectUser(user.id)">
                        <el-avatar :src="require('@/' + user.img)" class="user-avatar" shape="square" />
                        <div class="user-name">{{ user.userName }}</div>
                        <div class="user-role">{{ getRole(user.role) }}</div>
                    </div>
                    <div class="dialog-user-card" v-for="user in userAndRole.ordinaryVOList" :key="user.id"
                        @click="selectUser(user.id)" :class="{ selected: selectedBossID === user.id }">
                        <el-avatar :src="require('@/' + user.img)" class="user-avatar" shape="square" />
                        <div class="user-name">{{ user.userName }}</div>
                        <div class="user-role">普通成员</div>
                    </div>
                </div>
            </div>
            <span slot="footer" class="dialog-footer">
                <el-button @click="cancelUser">取 消</el-button>
                <el-button type="primary" @click.native="selectUserSubmit">确 定</el-button>
            </span>
        </el-dialog>
        <el-dialog title="请选择踢出的组员" :visible.sync="deleteUserShow" width="45%">
            <div class="dialog-team-users">
                <div class="dialog-user-list">
                    <div class="dialog-user-card"
                        v-for="user in this.userAndRole.adminVOList.filter(user => user.role === 2)" :key="user.id"
                        :class="{ selected: deleteUserId === user.id }" @click="selectDelectUser(user.id)">
                        <el-avatar :src="require('@/' + user.img)" class="user-avatar" shape="square" />
                        <div class="user-name">{{ user.userName }}</div>
                        <div class="user-role">{{ getRole(user.role) }}</div>
                    </div>
                    <div class="dialog-user-card" v-for="user in userAndRole.ordinaryVOList" :key="user.id"
                        @click="selectDelectUser(user.id)" :class="{ selected: deleteUserId === user.id }">
                        <el-avatar :src="require('@/' + user.img)" class="user-avatar" shape="square" />
                        <div class="user-name">{{ user.userName }}</div>
                        <div class="user-role">普通成员</div>
                    </div>
                </div>
            </div>
            <span slot="footer" class="dialog-footer">
                <el-button @click="cancelDelectUser">取 消</el-button>
                <el-button type="primary" @click.native="selectUserDelectSubmit">确 定</el-button>
            </span>
        </el-dialog>
        <el-dialog title="设置管理员" :visible.sync="setAdminShow" width="45%">
            <div class="dialog-team-users">
                <div class="dialog-user-list">
                    <div class="dialog-user-card"
                        v-for="user in this.userAndRole.adminVOList.filter(user => user.role === 2)" :key="user.id"
                        :class="{ selected: deleteUserId === user.id }">
                        <el-avatar :src="require('@/' + user.img)" class="user-avatar" shape="square" />
                        <div class="user-name">{{ user.userName }}</div>
                        <div class="user-role">{{ getRole(user.role) }}</div>
                        <el-button type="text" class="user-text" @click="removeAdminSubmit(user.id)">移除</el-button>
                    </div>
                    <div class="dialog-user-card" v-for="user in userAndRole.ordinaryVOList" :key="user.id"
                        @click="adminUserSelect(user.id)" :class="{ selected: adminUser === user.id }">
                        <el-avatar :src="require('@/' + user.img)" class="user-avatar" shape="square" />
                        <div class="user-name">{{ user.userName }}</div>
                        <div class="user-role">普通成员</div>
                    </div>
                </div>
            </div>
            <span slot="footer" class="dialog-footer">
                <el-button @click="cancelDelectUser">取 消</el-button>
                <el-button type="primary" @click.native="setAdminSubmit">设为管理员</el-button>
            </span>
        </el-dialog>

        <el-dialog title="团队管理" :visible.sync="managementTeamUserShow" width="30%">
            <div>
                <el-button type="text" @click="userShow = true">组长管理权转让</el-button>
                <br>
                <el-button type="text" @click="setAdminShow = true">设置团队管理员</el-button>
                <br>
                <el-button type="text" @click="deleteUserShow = true">踢出组员</el-button>
            </div>
            <span slot="footer" class="dialog-footer">
                <el-button @click="managementTeamUserShow = false">取 消</el-button>
            </span>
        </el-dialog>
        <el-dialog title="警告" :visible.sync="quitTeamShow" width="30%">
            <span>是否要退出团队？</span>
            <span slot="footer" class="dialog-footer">
                <el-button @click="quitTeamShow = false">取 消</el-button>
                <el-button type="danger" @click.native="quitTeamSubmit">确 定</el-button>
            </span>
        </el-dialog>
        <el-dialog title="警告" :visible.sync="deleteTeamShow" width="30%">
            <span>是否要解散团队？</span>
            <span slot="footer" class="dialog-footer">
                <el-button @click="deleteTeamShow = false">取 消</el-button>
                <el-button type="danger" @click.native="deleteTeamSubmit">确 定</el-button>
            </span>
        </el-dialog>
        <el-dialog title="请输入新团队名" :visible.sync="updateTeamNameShow" width="30%">

            <el-input v-model="newTeamName" placeholder="请输入新团队名"></el-input>
            <span slot="footer" class="dialog-footer">
                <el-button @click="cancleUpdateTeamName">取 消</el-button>
                <el-button type="primary" @click="updateTeamNameSubmit">确 定</el-button>
            </span>
        </el-dialog>
        <el-dialog title="邀请成员" :visible.sync="invitationUserShow" width="30%">

            <div class="user-input">
                <el-input v-model="invitationUser" placeholder="请输入邀请的用户名" @keydown.enter.native="addUser()"
                    class="invitation-input"></el-input>
                <el-button type="primary" @click="addUser" class="action-button">确定</el-button>
            </div>
            <div class="invited-users">
                <el-tag type="info" v-for="(user, index) in invitedUsers" :key="index" closable
                    @close="removeUser(index)">
                    {{ user }}
                </el-tag>
            </div>
            <span slot="footer" class="dialog-footer">
                <el-button @click="invitationUserCancle">取 消</el-button>
                <el-button type="primary" @click="invitationUsersubmit">确 定</el-button>
            </span>
        </el-dialog>
        <el-dialog title="发布任务" :visible.sync="createTaskShow" width="width">
            <div><el-form ref="form" :rules="rules" :model="createTaskFrom" label-width="80px">
                    <el-form-item label="任务标题" prop="createTask">
                        <el-input v-model="createTaskFrom.title" placeholder="请输入标题"></el-input>
                    </el-form-item>
                    <el-form-item label="是否提醒">
                        <el-switch v-model="createTaskFrom.isRemind"></el-switch>
                    </el-form-item>
                    <el-form-item label="提醒内容" v-show="createTaskFrom.isRemind">
                        <el-input v-model="createTaskFrom.remindContent" placeholder="请输入提醒内容"></el-input>
                    </el-form-item>
                    <el-form-item label="任务内容" prop="contend">
                        <el-input type="textarea" v-model="createTaskFrom.contend" placeholder="请输入任务内容"></el-input>
                    </el-form-item>
                    <el-form-item label="任务时间" required prop="time">
                        <div class="block">
                            <el-date-picker v-model="dateRange" type="datetimerange" range-separator="至"
                                @change="handleDateChange" start-placeholder="开始日期" end-placeholder="结束日期">
                            </el-date-picker>
                        </div>
                    </el-form-item>
                    <el-form-item>
                    </el-form-item>
                </el-form>
            </div>
            <div slot="footer">
                <el-button type="primary" round @click="SubmitTask">发布任务</el-button>
                <el-button round @click="returnTask">重置</el-button>
            </div>
        </el-dialog>

    </div>
</template>

<script>
import top10 from './report/top10.vue';
import completementTask from './report/completementTask.vue';
import maleFemalePercentage from './report/male-female-percentage.vue';
import noTaskPercentage from './report/noTaskPercentage.vue';
import {
    getTeamTaskList, getTaskList, getTeamIntroduction, getTeamUserList, selectUser
    , updateTeamName, deleteTeam, quitTeam, deleteTeamUser, getInvitationCode, changeIntroduction, managementUser,
    transferBoss, setAdmin, removeAdmin
} from '@/api/team';
import { mapMutations, mapState } from 'vuex'



export default {
    computed: {
        ...mapState(['teamName']),


    },
    data() {
        return {
            dateRange: [new Date().toISOString(), new Date().toISOString()],

            createTaskFrom: {
                teamName: null,
                title: '',
                isRemind: false,
                contend: '',
                startTime: '',
                endTime: '',
                remindContent: ""
            },
            createTaskShow: false,
            hovered: false, // 控制悬停状态
            adminUser: null,
            setAdminShow: false,
            adminList: [],
            quitUser: '',
            deleteUserShow: false,
            selectedBossID: null,
            userAndRole: { adminVOList: [], ordinaryVOList: [] },
            deleteUserId: null,
            invitationUser: '',
            invitedUsers: [],
            user: '',
            userShow: false,
            newTeamName: '',
            updateTeamNameShow: false,
            invitationUserShow: false,
            quitTeamShow: false,
            deleteTeamShow: false,
            managementTeamUserShow: false,
            tasks: [],
            introduction: '',
            task_id: null,
            name: '',
            selectedTask: '',
            taskOptions: [],
            users: [],
            showChangeIroduction: false,
            rules: {
                createTask: [
                    { required: true, message: '请输入任务标题', trigger: 'blur' },
                    { min: 1, max: 50, message: '长度在 1 到 50 个字符', trigger: 'blur' }
                ],
                remindContent: [
                    { required: true, message: '请输入提醒内容', trigger: 'blur', condition: () => this.createTaskFrom.isRemind }
                ],

                contend: [
                    { required: true, message: '请输入任务内容', trigger: 'blur' },
                    { min: 1, max: 200, message: '长度在 1 到 200 个字符', trigger: 'blur' }
                ],
                time: [
                    { validator: this.validateTime, trigger: 'change' }
                ]
            }

        };
    },
    components: {
        top10,
        completementTask,
        maleFemalePercentage,
        noTaskPercentage
    },

    methods: {
        async SubmitTask() {
            this.createTaskFrom.teamName = this.teamName
            console.log(this.createTaskFrom)
            this.returnTask()
        },
        handleDateChange(value) {
            this.createTaskFrom.startTime = value[0]; // 开始时间
            this.createTaskFrom.endTime = value[1];   // 结束时间
        },
        async submitTask() {
            this.createTaskFrom.teamName = this.teamName

        },
        returnTask() {
            this.createTaskFrom = {
                teamName: null,
                title: '',
                isRemind: false,
                contend: '',
                startTime: '',
                endTime: '',
                remindContent: ""
            }
            this.dateRange = [new Date().toISOString(), new Date().toISOString()]
        },

        async createTask() {
            this.createTaskShow = true

        },
        validateTime(rule, value, callback) {
            if (!this.createTaskFrom.startTime || !this.createTaskFrom.endTime) {
                return callback(new Error('请选择任务时间'));
            }
            if (this.createTaskFrom.startTime >= this.createTaskFrom.endTime) {
                return callback(new Error('开始时间必须早于结束时间'));
            }
            callback();
        },
        async removeAdminSubmit(id) {
            const data = { teamName: this.teamName, removeUserId: id }
            const res = await removeAdmin(data);
            if (res.code === 200) {
                this.$message.success("移除成功")
                this.getUserAndRole()
            } else {
                this.$message.error(res.msg)
            }
            this.setAdminShow = false
            this.functionAll()

        },
        bossID() {

            return this.userAndRole.adminVOList.filter(user => user.role === 3);
        },
        async setAdminSubmit() {
            if (this.adminUser === null) {
                this.$message.error("请选择一个用户")
                this.setAdminShow = false
                return
            }
            const data = { teamName: this.teamName, transferUserId: this.adminUser }
            try {
                const res = await setAdmin(data)
                if (res.code === 200) {
                    this.$message.success("设置成功")
                    this.setAdminShow = false
                    this.getUserAndRole()
                    this.functionAll()
                } else {
                    this.$message.error(res.msg)
                }
            } catch (error) {
                this.$message.error("设置失败")
            }
        },
        async selectUserDelectSubmit() {
            if (this.deleteUserId === null) {
                this.$message.error("请选择一个用户")
                this.deleteUserShow = false
                return
            } else {
                const res = await deleteTeamUser({ teamName: this.teamName, deleteUserId: this.deleteUserId })
                if (res.code === 200) {
                    this.$message.success("删除成功")
                    this.deleteUserShow = false
                    this.deleteUserId = null
                    this.getUserAndRole()
                    this.functionAll()
                } else {
                    this.$message.error(res.msg)
                }
            }
        },
        adminUserSelect(id) {
            console.log("selectadminUser" + id);
            this.adminUser = this.adminUser === id ? null : id;
        },
        selectDelectUser(id) {
            console.log("selectdelectUser" + id);
            this.deleteUserId = this.deleteUserId === id ? null : id;
        },
        cancelDelectUser() {
            this.deleteUserId = null
            this.deleteUserShow = false
        },

        async selectUserSubmit() {

            if (this.selectedBossID === null) {
                this.$message.error("请选择一个用户")
                this.userShow = false
                this.selectedBossID = null
                return
            } else if (this.bossID[0].id === this.selectedBossID) {
                this.$message.error("用户" + this.bossID[0].userName + "已经为组长")
                this.userShow = false
                this.selectedBossID = null
                return
            }
            console.log("transferUserId" + this.selectedBossID);
            const res = await transferBoss({ teamName: this.teamName, transferUserId: this.selectedBossID })
            if (res.code === 200) {
                this.getUserAndRole()
                this.$message.success("转让成功")
                this.userShow = false
                this.selectedBossID = null

            } else {
                this.$message.error(res.msg)
            }

        },
        cancelUser() {
            this.userShow = false
            this.selectedBossID = null
        },
        selectUser(id) {
            console.log("selectUser" + id);
            this.selectedBossID = this.selectedBossID === id ? null : id;
        },
        invitationUserCancle() {
            this.invitedUsers = []
            this.invitationUserShow = false

        },
        invitationUsersubmit() {
            this.invitationUserShow = false

        },
        cancleUpdateTeamName() {
            this.updateTeamNameShow = false
            this.newTeamName = ''
        },
        ...mapMutations(['changeTaskId']),
        async getInvitation() {
            console.log("邀请");
            const res = await getInvitationCode(this.teamName);
            console.log(res.code);
            if (res.code === 200) {
                navigator.clipboard.writeText(res.data).then(() => {
                    this.$message.success("邀请码已复制到剪贴板");
                }).catch(() => {
                    this.$message.error("复制失败");
                });
            } else {
                this.$message.error(res.msg)
            }
        },

        async getUserAndRole() {
            const res = await managementUser(this.teamName);
            console.log(res);

            if (res.code === 200) {
                this.userAndRole = res.data
                console.log(this.userAndRole);
            } else {
                this.$message.error(res.msg)
            }
            console.log(this.userAndRole);

        },
        updateTeamNameSubmit() {
            console.log("更改");
            const data = {
                teamName: this.teamName,
                newTeamName: this.newTeamName
            }
            updateTeamName(data).then(res => {
                if (res.code === 200) {
                    this.$message.success("修改成功")
                } else {
                    this.$message.error(res.msg)

                }
            }).catch(err => {
                this.$message.error("修改失败")
            })
            this.newTeamName = ''
            this.teamName = this.newTeamName
            this.functionAll()
            this.updateTeamNameShow = false;
        },
        managementTeamUser() { },

        async quitTeamSubmit() {
            const res = await quitTeam(this.teamName);
            if (res.code === 200) {
                this.$message.success("退出成功")
            } else {
                this.$message.error(res.msg)
            }
            console.log("退出");
            this.$router.push('/api/admin/home/team')

            this.quitTeamShow = false;

        },
        async deleteTeamSubmit() {
            console.log("解散");
            const data = {
                teamName: this.teamName
            }
            const res = await deleteTeam(data);
            if (res.code === 200) {
                this.$message.success("解散成功")
            } else {
                this.$message.error(res.msg)
            }
            this.deleteTeamShow = false;
            this.$router.push('/api/admin/home/team')
        },
        getRole(role) {
            switch (role) {
                case 1:
                    return "组员"
                case 2:
                    return "管理员"
                case 3:
                    return "组长"
                default:
                    return "异常身份"
            }

        },

        getStatusClass(status) {
            switch (status) {
                case "1":
                    console.log("未完成");
                    return 'task-status-incomplete'; // 未完成
                case "2":
                    return 'task-status-complete'; // 已完成
                case "3":
                    return 'task-status-in-progress'; // 进行中
                case "4":
                    return 'task-status-not-started'; // 待审核
                default:
                    return ''; // 默认类
            }
        },
        // 新增方法：根据状态返回对应文本
        getStatusText(status) {
            switch (status) {
                case "1":
                    return '未完成';
                case "2":
                    return '已完成';
                case "3":
                    return '进行中';
                case "4":
                    return '待审核';
                default:
                    return '未知状态'; // 默认状态
            }
        },


        async getTaskListData() {
            const res = await getTeamTaskList(this.name);

            if (res.code === 200) {
                this.tasks = res.data;
                console.log('getTaskList');
                console.log(this.tasks);
            } else {
                this.$message.error(res.msg);
            }
        },
        async getUserList() {
            const res = await getTeamUserList(this.name);

            if (res.code === 200) {
                this.users = res.data;
                console.log('getUserList');
                console.log(this.users);
            } else {
                this.$message.error(res.msg);
            }
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
        async changeIntroduction() {
            const data = {
                teamName: this.teamName,
                introduction: this.introduction
            }
            const res = await changeIntroduction(data);
            if (res.code === 200) {
                this.$message.success("修改成功")
            } else {
                this.$message.error(res.msg)
            }
        },
        async getIntroduction() {
            const res = await getTeamIntroduction(this.teamName);
            if (res.code === 200) {
                this.introduction = res.data;
                console.log(this.introduction);
            } else {
                this.$message.error(res.msg);
            }
        },
        changeTask(value) {
            this.task_id = value;
            this.changeTaskId(this.task_id);
        },
        async getTaskList() {
            const res = await getTaskList(this.name);
            console.log(res);
            if (res.code === 200) {
                console.log(res);
                this.taskOptions = res.data;
                if (this.taskOptions.length === 0) {
                    this.changeTask(null);
                    return;
                }
                this.task_id = res.data[0].taskId;
                this.changeTask(this.task_id);
            } else {
                this.$message.error(res.msg);
            }
        },

        back() {
            this.$router.push({ name: 'team' });
        },
        functionAll() {
            this.getTaskListData();
            this.getIntroduction();
            this.getTaskList();
            this.getUserList();
            this.getUserAndRole()
        },
    },
    mounted() {
        this.functionAll();

    },
    created() {
        this.name = this.$route.params.teamName;
        console.log(this.name);
    }
}
</script>

<style scoped>
.el-dialog {
    background-color: #f0f0f0;
    /* 更改为你想要的颜色 */
}

.task-list {
    max-height: 300x;
    /* 设置最大高度 */
    overflow-y: auto;
    /* 启用垂直滚动 */

}

.task-item {
    background-color: #f9f9f9;
    border-radius: 10px;
    padding: 1em;
    margin-bottom: 1em;
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
}

.task-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.task-name {
    font-weight: bold;
    font-size: 1.1em;
}

.header-row {
    display: flex;
    justify-content: space-between;
    align-items: center;
    width: 100%;
}

.list-title {
    margin: 0;
}

.edit-icon {
    display: block;
    cursor: pointer;
    /* 鼠标变成手形 */
    transition: color 0.3s;
    /* 添加过渡效果 */
}

.edit-icon.hovered {
    color: #ff40c9;
    /* 悬停时改变颜色 */
}

.task-status {
    padding: 0.3em 0.5em;
    border-radius: 5px;
    color: white;
}


.task-status-complete {
    background-color: #4CAF50;
    /* 完成状态绿色 */
}

.task-status-incomplete {
    background-color: #f44336;
    /* 未完成状态红色 */
}

.task-status-in-progress {
    background-color: #409EFF;
}

.task-status-not-started {
    background-color: #ff9800;
}

.team-user-group {
    padding-top: 1em;
}


.task-content {
    margin-top: 0.5em;
    color: #555;
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
    /* 强制在一行内显示 */
}

.team-users {
    height: 85%;
    /* 根据需要调整高度 */
    text-align: left;
}

.user-list {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(80px, 1fr));
    /* 响应式网格布局 */
    gap: 10px;
    /* 用户卡片之间的间距 */
    padding: 1em;
    overflow-y: auto;
    /* 需要时启用滚动 */
    max-height: 300px;
    /* 设置最大高度以便滚动 */
}

.dialog-team-users {
    height: 85%;
    text-align: left;
    padding: 1em;
    /* 添加内边距 */

    border-radius: 8px;
    /* 圆角 */

}

.dialog-user-card.selected {
    background-color: rgb(235, 242, 255);
    /* 选中时的背景颜色 */
    border-color: rgb(221, 232, 255);
    /* 选中时的边框颜色 */
}

.dialog-user-list {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(80px, 1fr));
    gap: 10px;
    /* 用户卡片之间的间距 */
    padding: 1em;
    overflow-y: auto;
    /* 需要时启用滚动 */
    max-height: 300px;
    /* 设置最大高度以便滚动 */
}

.dialog-user-card {
    display: flex;
    flex-direction: column;
    align-items: center;
    /* 垂直居中内容 */
    background: #fff;
    /* 背景颜色 */
    border-radius: 8px;
    /* 圆角 */
    padding: 10px;
    /* 内边距 */
    transition: transform 0.2s, box-shadow 0.2s;
    /* 过渡效果 */
    cursor: pointer;
    /* 鼠标悬停时显示手指图标 */

}

.header-row {
    display: flex;
    /* 使用 flexbox 布局 */

    /* 在主轴上分散对齐 */
    justify-self: start;
    /* 垂直居中对齐 */
    width: 100%;
    /* 确保占满容器宽度 */
}

.list-title {
    margin: 0;
    /* 去掉默认的 margin */
}

.dialog-user-card:hover {
    transform: scale(1.05);
    /* 鼠标悬停时放大 */
    box-shadow: 0 4px 20px rgb(221, 232, 255)
        /* 鼠标悬停时阴影效果增强 */
}

.dialog-user-avatar {
    width: 60px;
    /* 调整头像大小 */
    height: 60px;
    /* 调整头像大小 */
    margin-bottom: 5px;
    /* 增加头像下方的间距 */
    border-radius: 50%;
    /* 圆形头像 */
    object-fit: cover;
    /* 确保图片保持比例并填充 */
}

.user-card {
    display: flex;
    flex-direction: column;
    align-items: center;
    /* 垂直居中内容 */
}

.user-avatar {
    width: 60px;
    /* 调整头像大小 */
    height: 60px;
    /* 调整头像大小 */
    margin-bottom: 2px;
    /* 减少头像下方的间距 */
}

.user-name {
    font-size: 0.875em;
    /* 用户名称的字体大小 */
    text-align: center;
    /* 用户名称居中 */
    margin-top: 2px;
    /* 减少名称上方的间距 */
}

.user-role {
    font-size: 0.575em;
    /* 用户名称的字体大小 */
    text-align: center;
    /* 用户名称居中 */
    margin-top: 1px;
}

.user-text {
    font-size: 0.875em;
    /* 用户名称的字体大小 */
    text-align: center;
    /* 用户名称居中 */
    margin-top: 2px;
}

.task-but {
    justify-self: end;
}

.list-title {
    font-size: 1.375em;
    /* 标题的字体大小 */
    margin: 0;
    padding: 0.1875em 0 0.625em;
    /* 标题的内边距 */
}

.navigation {
    text-align: center;
    /* 导航按钮居中 */
    margin-top: 10px;
    /* 导航按钮上方的间距 */
}

.introduction {
    padding-left: 1em;
    color: #fff;
}

.title-introduction {
    padding-top: 0.5em;
    margin-left: 1em;
    color: #fff;
}

.team-introduction {
    margin-top: 5em;
    margin-left: 0.5em;
    width: 95%;
    height: 30%;
    background-color: #409EFF;
    position: relative;
    border-radius: 20px;
}

.user-input {
    display: flex;
    align-items: center;
}

.invited-users {
    margin-top: 10px;
}

.title {
    padding-top: 1em;
    margin-left: 1em;
    font-size: 1.25em;
    color: #409EFF;
}

.set_title {
    margin-left: 1.5em;
    font-size: 1.25em;
    color: #409EFF;

}

.el-popover {
    background: #000022;
    border-color: #000022;
    border-radius: 10px;
    opacity: 0.92;
    color: #fff;
}

.name {
    font-size: 1.25em;
    padding-top: 1em;
    margin-left: 1em;
    color: #fff;
}

.team-name {
    margin-left: 0.5em;
    width: 90%;
    height: 25%;
    background-color: #409EFF;
    position: relative;
    border-radius: 20px;
    margin-bottom: 20px;
}

.spacing {
    height: px;
}

.set {
    border-radius: 20px;
    margin: 1em;
    width: 100%;
    height: 100%;
    max-height: 270px;
    background-color: rgb(240, 245, 255);
    position: absolute;
    bottom: -35%;
    right: -10%;

}

html,
body {
    margin: 0;
    padding: 0;
    height: 100%;
    font-family: Arial, sans-serif;
}

.inputDeep>>>.el-select {
    border: none !important;
    box-shadow: none !important;
}

.inputDeep>>>.el-input__inner {
    border: none !important;
}

.team-container {
    height: 100%;
    width: 100%;
}

.button-back {
    color: #000;
    font-size: 1.125em;
}

.flex-container {
    display: flex;
    justify-content: flex-start;
    width: 100%;
    height: 95%;
}

.team-group {
    width: 85%;
    height: 100%;
    margin-right: 1.25em;
    display: flex;
    flex-direction: column;
}

.user-list,
.task-list {
    height: 95%;
    max-height: 285px;
    background-color: #fff;
    border-radius: 30px;
    padding: 1em;
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
}

.team-report {
    height: auto;
    flex: 1;
    background-color: rgb(255, 255, 255);
    margin: 1.25em;
    border-radius: 30px;
    display: flex;
    flex-direction: column;
}

.task-select {
    height: 2.5em;
    padding-left: 1em;
    padding-top: 0.5em;
    padding-bottom: 0.625em;
}

.report-header {
    flex-grow: 1;
    display: flex;
    align-items: stretch;
}

.top10 {
    width: 70%;
    height: 89%;
    color: #fff;
    padding: 1em;
    border-radius: 5px;
}

.task-complete {
    width: 30%;
    color: #fff;
    padding: 1em;
    border-radius: 5px;
    flex-grow: 1;
}

.list-group {
    height: 48%;
    display: flex;
    justify-content: space-between;
    align-items: flex-start;
    margin: 1em 1.25em;
}

.team-users,
.team-task {
    height: 85%;
    width: 49%;
    text-align: left;
}

.list-title {
    font-size: 1.375em;
    margin: 0;
    padding: 0.1875em 0 0.625em;
}

.my-team {
    height: 100%;
    width: 30%;
    background-color: #fff;
    border-radius: 30px;
}

.set-group {
    display: grid;
    grid-template-columns: repeat(2, 1fr);
    gap: 10px;
    padding-top: 0.25em;
    padding-left: 2em;
    padding-right: 1.25em;
}

.set_div {
    width: 85%;
}

.responsive-button {
    width: 100%;
    padding: 0.625em 0;
}

.percentage-container {
    display: flex;
    /* 使用 Flexbox 进行水平排列 */
    justify-content: space-between;
    /* 在容器内均匀分布 */
    margin: 1em;
    /* 添加外边距 */
    color: #fff;
    /* 设置文字颜色 */
    width: 100%;
    /* 满宽 */
}

.male-female-percentage,
.no-task-percentage {

    width: 48%;
    height: 100%;
    /* 设置宽度以便于排列 */
    background-color: rgb(240, 245, 255);
    /* 设置背景颜色以便于可视化 */

    /* 添加内边距 */
    border-radius: 10px;
    /* 添加圆角 */
}

.male-female-percentage {
    margin-left: 0.4em;
    float: left;
}

.no-task-percentage {
    margin-right: 0.5em;
    float: right;
}
</style>