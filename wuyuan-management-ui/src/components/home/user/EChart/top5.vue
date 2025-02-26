<template>
    <div ref="chart" class="echart" style="width: 100%; height: 100%;"></div>
</template>

<script>
import * as echarts from 'echarts';
import { getTop5 } from '@/api/home/taskAndTeamData';
import { mapState } from 'vuex';

export default {
    data() {
        return {
            chartInstance: null,
            option: {
                color: '#e17055', // 设置柱状图的颜色
                tooltip: {
                    trigger: 'item',
                    formatter: '{b}: {c} 完成的任务' // 显示格式
                },
                xAxis: {
                    type: 'category',
                    data: [],
                    axisLabel: {
                        rotate: 45 // 旋转标签
                    }
                },
                yAxis: {
                    type: 'value',
                    name: '任务完成数'
                },
                series: [
                    {
                        name: '任务完成数(top5)',
                        data: [],
                        type: 'bar',
                        animationDuration: 1000,
                        emphasis: {
                            focus: 'series',
                            itemStyle: {
                                borderWidth: 2,
                                borderColor: '#fff'
                            }
                        }
                    }
                ],
                backgroundColor: '#ffffff', // 设置图表背景颜色为白色
                animationDurationUpdate: 1000
            }
        };
    },

    computed: {
        ...mapState(['teamId'])
    },
    watch: {
        teamId: {
            immediate: true,
            handler() {
                this.getData();
            }
        }
    },
    mounted() {
        this.chartInstance = echarts.init(this.$refs.chart); // 初始化 ECharts 实例
        this.chartInstance.setOption(this.option); // 设置图表配置
        window.addEventListener('resize', this.onResize); // 监听窗口大小变化
        this.getData();
    },
    beforeDestroy() {
        window.removeEventListener('resize', this.onResize); // 清除事件监听
        this.chartInstance.dispose(); // 销毁 ECharts 实例
    },
    methods: {
        onResize() {
            this.chartInstance.resize(); // 调整图表大小
        },
        async getData() {
            try {
                const ref = await getTop5(this.teamId);
                if (ref.code === 200) {
                    console.log(ref.data);
                    this.option.xAxis.data = ref.data.names;
                    this.option.series[0].data = ref.data.values;
                    this.chartInstance.setOption(this.option);
                } else {
                    this.$message.error(ref.msg);
                }
            } catch (error) {
                if (error.response && error.response.status === 401) {
                    this.$message.error('未授权，请重新登录');
                } else {
                    this.$message.error('请求失败');
                }
            }
        }
    }
};
</script>

<style lang="less" scoped>
.echart {
    background-color: #ffffff;
    /* 设置背景颜色为白色 */
    border-radius: 8px;
    /* 圆角 */
    padding: 20px;
    /* 内边距 */
}
</style>