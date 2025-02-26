<template>
    <div class="chart-container">
        <div ref="barChart" class="bar-chart"></div>
    </div>
</template>

<script>
import * as echarts from 'echarts';
import { getTop10 } from '@/api/team';
import { mapState } from 'vuex';
export default {
    computed: {
        ...mapState(['teamName']),
    },
    data() {
        return {
            chart: null,
            // 定义数据和颜色
            chartData: [

            ],
            colors: [
                'rgba(1, 119, 204, 1)',  // 深蓝色
                'rgba(0, 162, 255, 1)',  // 浅蓝色
                'rgba(0, 132, 255, 1)',  // 蓝色
                'rgba(0, 102, 204, 1)',  // 深蓝色
                'rgba(0, 84, 153, 1)',   // 深蓝色
                'rgba(0, 162, 255, 1)',  // 浅蓝色
                'rgba(0, 132, 255, 1)'   // 蓝色
            ]
        };
    },
    mounted() {
        this.getTop10List();
        this.initChart();
        window.addEventListener('resize', this.resizeChart);
    },
    beforeDestroy() {
        window.removeEventListener('resize', this.resizeChart);
        this.chart.dispose();
    },
    methods: {
        async getTop10List() {

            const res = await getTop10(this.teamName);

            if (res.code === 200) {
                this.chartData = res.data;
                this.chart.setOption(this.getChartOptions());
            } else {
                this.$message.error(res.msg);
            }
        },
        initChart() {
            this.chart = echarts.init(this.$refs.barChart);
            this.chart.setOption(this.getChartOptions());
        },
        getChartOptions() {
            return {
                title: {
                    text: '团队完成任务量top10',
                    left: 'center',
                    textStyle: {
                        color: '#003366', // 深蓝色
                        fontSize: 24,
                        fontWeight: 'bold'
                    }
                },
                grid: {
                    top: 50,
                    bottom: 50,
                    left: 40,
                    right: 40
                },
                xAxis: {
                    type: 'category',
                    data: this.chartData.map(item => item.name), // 使用数据名称
                    axisLabel: {
                        color: '#005b96' // 蓝色
                    }
                },
                yAxis: {
                    type: 'value',
                    min: 0,
                    axisLabel: {
                        color: '#005b96' // 蓝色
                    }
                },
                series: [
                    {
                        data: this.chartData.map((item, index) => ({
                            value: item.value,
                            itemStyle: { color: this.colors[index] } // 使用颜色数组
                        })),
                        type: 'bar',
                        itemStyle: {
                            borderRadius: [10, 10, 10, 10], // 设置所有角为圆角
                        },
                        barWidth: '30%', // 设置条形宽度
                        emphasis: {
                            itemStyle: {
                                color: 'rgba(0, 162, 255, 0.8)' // 鼠标悬停时的颜色
                            }
                        }
                    }
                ],
                tooltip: {
                    trigger: 'item',
                    backgroundColor: 'rgba(0, 0, 0, 0.7)',
                    textStyle: {
                        color: '#fff'
                    }
                }
            };
        },
        resizeChart() {
            if (this.chart) {
                this.chart.resize(); // 重新调整图表大小
            }
        }
    }
};
</script>

<style scoped>
.chart-container {
    width: 100%;
    height: 400px;
    /* 设置图表的高度 */
    position: relative;
}

.bar-chart {
    width: 100%;
    /* 使 ECharts 容器宽度为 100% */
    height: 100%;
    /* 使 ECharts 容器高度为 100% */
    border-radius: 10px;
    /* 圆角效果 */
}
</style>