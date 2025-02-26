<template>
    <div class="task">
        <div class="team">
            <div class="data">
                <h2 class="title">团队名</h2>
                <el-dropdown>
                    <span class="el-dropdown-link" style="font-size: 120%;">
                        {{ nameTeam }}<i class="el-icon-arrow-down el-icon--right"></i>
                    </span>
                    <el-dropdown-menu slot="dropdown" class="custom-dropdown">
                        <el-dropdown-item v-for="team in teamList" :key="team.id" @click.native="selectTeam(team)">
                            {{ team.taskName }}
                        </el-dropdown-item>
                    </el-dropdown-menu>
                </el-dropdown>
            </div>

            <div class="data">
                <h2 class="title">未完成任务</h2>
                <span class="content">{{ noTask }}</span>
            </div>

            <div class="data">
                <h2 class="title">成员数量</h2>
                <span class="content">{{ count }}</span>
            </div>
        </div>
        <div class="type_and_attend">
            <div class="type">
                <taskType></taskType>
            </div>
            <div class="attend">
                <top5></top5>
            </div>
        </div>
        <div class="complete">
            <task-statistics></task-statistics>
        </div>
    </div>
</template>

<script>
import taskType from './EChart/taskType.vue';
import taskStatistics from './EChart/taskStatistics.vue';
import top5 from './EChart/top5.vue';
import { getTeamList, countTeam, getNoTask } from '@/api/home/taskAndTeamData';
import { mapState, mapMutations } from 'vuex';

export default {
    components: {
        taskType, top5, taskStatistics
    },
    data() {
        return {
            nameTeam: "",
            teamList: [],
            count: null,
            noTask: null
        };
    },
    computed: {
        ...mapState(['id', 'teamId'])
    },
    methods: {
        ...mapMutations(['changeTeamId']),
        selectTeam(team) {
            console.log(`获取团队id: ${team.id}`);
            this.changeTeamId(team.id);
            this.nameTeam = team.taskName;
            this.auto();
        },
        async getList(id) {
            const req = await getTeamList(id);
            console.log("获取团队列表");
            console.log(req);
            if (req.code === 200) {
                this.teamList = req.data;
                this.changeTeamId(this.teamList[0].id);
                this.nameTeam = this.teamList[0].taskName;
            } else {
                this.$message.error(req.msg);
            }
        },
        async getCount(id) {
            const req = await countTeam(id);
            if (req.code === 200) {
                this.count = req.data;
            } else {
                this.$message.error(req.msg);
            }
        },
        async getNo(id) {
            const req = await getNoTask(id);
            if (req.code === 200) {
                this.noTask = req.data;
            } else {
                this.$message.error(req.msg);
            }
        },
        auto() {
            this.getCount(this.teamId);
            this.getNo(this.teamId);
        }
    },
    mounted() {
        this.getList(this.id);
        this.auto();
    }
}
</script>

<style scoped>
.task {
    width: 100%;
    height: 100%;
    display: flex;
    flex-direction: column;
    align-items: flex-start;
    padding: 20px;
    background-color: #ffffff;
    border-radius: 30px;
    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
}

.team {
    display: flex;
    justify-content: space-between;
    width: 100%;
    margin-bottom: 20px;
}

.data {
    border-radius: 15px;
    width: 30%;
    height: 125%;
    background-color: #f5f5f5;
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
    margin: 0 10px;
    transition: transform 0.3s, box-shadow 0.3s;
}

.data:hover {
    transform: scale(1.05);
    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
}

.complete {
    border-radius: 15px;
    display: flex;
    justify-content: space-between;
    width: 97.5%;
    margin-top: 1%;
    box-shadow: 0 1px 2px rgba(0, 0, 0, 0.1);
    padding: 0.1%;
    background-color: #ffffff;
    height: 35.6%;
}

.type_and_attend {
    display: flex;
    justify-content: space-between;
    width: 98%;
    margin-top: 5%;
    padding: 0.1%;
    height: 38%;
}

.type,
.attend {
    flex: 1;
    margin: 0 10px;
    background-color: #ffffff;
    border-radius: 10px;
    height: 100%;
    display: flex;
    justify-content: center;
    align-items: center;
    box-shadow: 0 1px 2px rgba(0, 0, 0, 0.1);
}

.custom-dropdown {
    min-width: 150px;
    /* 设置最小宽度 */
    max-width: 300px;
    /* 设置最大宽度 */
    width: 200px;
    /* 设置具体宽度 */
    max-height: 300px;
    /* 设置最大高度 */
    overflow-y: auto;
    /* 超出部分出现滚动条 */
}
</style>