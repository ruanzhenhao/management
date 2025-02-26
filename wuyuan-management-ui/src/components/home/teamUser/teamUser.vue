<template>
    <div class="team-container">
        <el-form ref="teamForm" :model="teamForm" label-width="50px" :inline="true">
            <el-form-item label="姓名">
                <el-input v-model="teamForm.username" placeholder="请输入姓名" style="width: 120px;"></el-input>
            </el-form-item>
            <el-form-item label="性别">
                <el-select v-model="teamForm.sex" clearable placeholder="请选择" style="width: 100px;">
                    <el-option label="男" value="男"></el-option>
                    <el-option label="女" value="女"></el-option>
                </el-select>
            </el-form-item>
            <el-form-item label="团队选择" label-width="80px">
                <el-select v-model="teamForm.teamId" placeholder="请选择" style="width: 150px;">
                    <el-option v-for="item in teamList" :key="item.id" :label="item.taskName" :value="item.id">
                    </el-option>
                </el-select>
            </el-form-item>
            <el-form-item label="权限">
                <el-select v-model="teamForm.role" placeholder="请选择" clearable style="width: 100px;">
                    <el-option label="组员" value="3"></el-option>
                    <el-option label="管理员" value="2"></el-option>
                    <el-option label="组长" value="1"></el-option>
                </el-select>
            </el-form-item>
            <el-form-item label="地址">
                <el-input v-model="teamForm.address" placeholder="请输入地址" style="width: 250px;"></el-input>
            </el-form-item>
            <el-form-item label="电话">
                <el-input v-model="teamForm.phone" placeholder="请输入电话" style="width: 175px;"></el-input>
            </el-form-item>

            <el-form-item>
                <el-button type="primary" @click.native="submitForm">提交</el-button>
                <el-button @click.native="resetForm">重置</el-button>
                <el-button type="warning">管理</el-button>
            </el-form-item>
        </el-form>
        <el-table :data="teamRequist.records" style="width: 100%">
            <el-table-column label="头像" align="center" width="150">
                <template slot-scope="scope">
                    <el-avatar shape="square" :size="50" :src='require("@/" + scope.row.img)'></el-avatar>
                </template>
            </el-table-column>
            <el-table-column prop="username" align="center" label="姓名" width='200'></el-table-column>
            <el-table-column prop="sex" align="center" label="性别" width="150"></el-table-column>
            <el-table-column prop="phone" align="center" label="电话" width="200"></el-table-column>
            <el-table-column prop="role" align="center" label="权限" width="170"></el-table-column>
            <el-table-column prop="noTask" align="center" label="未完成任务数" width="180"></el-table-column>
            <el-table-column prop="email" align="center" label="Email" width="200"></el-table-column>
            <el-table-column prop="address" align="center" label="住址"></el-table-column>
        </el-table>
        <div class="block">

            <el-pagination :total="teamRequist.total" @size-change="handleSizeChange"
                @current-change="handleCurrentChange" :current-page="teamForm.page" :page-sizes="[10, 20, 30, 40]"
                :page-size="teamForm.pageSize" layout="prev, pager, next, sizes, total" style="text-align: center;">
            </el-pagination>
        </div>

    </div>
</template>

<script>
import { mapState, mapMutations } from 'vuex'
import { getTeamList } from '@/api/home/taskAndTeamData'
import { getTeanData } from '@/api/teamUser'


const options =
{
    data() {
        return {
            teamRequist:
            {
            },

            teamList: [],
            teamForm: {
                username: '',
                teamId: 1,
                sex: '',
                address: '',
                phone: '',
                role: '',
                email: '',
                page: 1,
                pageSize: 10
            }
        }

    },
    methods: {
        ...mapMutations(['changeTeamId']),
        submitForm() {
            console.log(this.teamForm)
            this.getTeamRequist()
        },
        resetForm() {
            console.log('重置')
            this.teamForm =
            {
                username: '',
                teamId: this.teamList[0].id,
                sex: '',
                address: '',
                phone: '',
                email: '',
                role: '',
                page: 1,
                pageSize: 10
            }
        },
        async getList(id) {
            console.log(id)
            const req = await getTeamList(id);
            if (req.code === 200) {
                this.teamList = req.data

                console.log(this.teamForm)
                console.log(this.teamList)
            } else {
                this.$message.error(req.msg)
            }
        },
        handleSizeChange(size) {
            this.teamForm.pageSize = size
            this.getTeamRequist()
        },
        handleCurrentChange(page) {
            this.teamForm.page = page
            this.getTeamRequist()
        },
        async getTeamRequist() {
            const req = await getTeanData(this.teamForm);
            if (req.code === 200) {
                this.teamRequist = req.data
                console.log(this.teamRequist)
            } else {
                this.$message.error(req.msg)
            }
        },
    },
    mounted() {

        this.getList(this.id)
        this.getTeamRequist()

    },
    computed:
    {
        ...mapState(['id'])
    }
}



export default options
</script>