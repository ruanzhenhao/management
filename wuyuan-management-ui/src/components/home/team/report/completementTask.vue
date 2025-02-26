<template>
    <div class="chart-container">
        <div ref="pieChart" class="pie-chart"></div>
    </div>
</template>

<script>
import * as echarts from 'echarts';
import { mapState } from 'vuex';
import { completeTask } from '../../../../api/team'; // 确保路径正确

export default {

    computed: {
        ...mapState(['taskId']),
    },
    watch: {
        taskId: {
            immediate: true,
            handler() {
                this.getCompletementTask();
            }
        }
    },
    data() {
        return {
            chart: null,
            chartData: [],
            colors: [
                'rgba(1, 119, 204, 1)',  // 深蓝色
                'rgba(0, 162, 255, 1)',  // 浅蓝色
                'rgba(0, 132, 255, 1)',  // 蓝色
                'rgba(0, 102, 204, 1)',  // 深蓝色
                'rgba(0, 84, 153, 1)'     // 深蓝色
            ]
        };
    },
    mounted() {
        this.initChart();
        this.getCompletementTask();
        window.addEventListener('resize', this.resizeChart);
    },
    beforeDestroy() {
        window.removeEventListener('resize', this.resizeChart);
        if (this.chart) {
            this.chart.dispose();
        }
    },
    methods: {
        async getCompletementTask() {
            try {
                const res = await completeTask(this.taskId);
                console.log('请求成功');
                console.log(res);// 确保这个函数是异步的
                if (res.code === 200) {
                    // 格式化数据
                    this.chartData = res.data.map(item => ({
                        name: item.type,
                        value: item.value
                    }));
                    this.chart.setOption(this.getChartOptions());
                } else {
                    this.$message.error(res.msg);
                }
            } catch (error) {
                console.error('请求失败:', error);
                this.$message.error('获取任务数据失败');
            }
        },
        initChart() {
            this.chart = echarts.init(this.$refs.pieChart);
            this.chart.setOption(this.getChartOptions());
        },
        getChartOptions() {
            return {
                title: {
                    text: '任务完成情况',
                    left: 'center',
                    top: 20,
                    textStyle: {
                        color: '#003366',
                        fontSize: 24,
                        fontWeight: 'bold'
                    }
                },
                tooltip: {
                    trigger: 'item',
                    backgroundColor: 'rgba(0, 0, 0, 0.7)',
                    textStyle: {
                        color: '#fff'
                    }
                },
                series: [
                    {
                        name: '任务完成情况(人)',
                        type: 'pie',
                        radius: '45%',
                        center: ['50%', '50%'],
                        data: this.chartData.map((item, index) => ({
                            value: item.value,
                            name: item.name,
                            itemStyle: { color: this.colors[index % this.colors.length] } // 使用循环的颜色
                        })),
                        label: {
                            show: true,
                            formatter: '{b}: {c} ({d}%)',
                            color: '#003366',
                            fontSize: 14
                        },
                        itemStyle: {
                            shadowBlur: 20,
                            shadowColor: 'rgba(0, 0, 0, 0.5)'
                        },
                        animationType: 'scale',
                        animationEasing: 'elasticOut',
                        animationDuration: 1000,
                        animationDurationUpdate: 500,
                        animationDelay: (idx) => Math.random() * 200
                    }
                ]
            };
        },
        resizeChart() {
            if (this.chart) {
                this.chart.resize();
            }
        }
    }
};
</script>

<style scoped>
.chart-container {
    width: 100%;
    height: 400px;
    overflow: hidden;
    position: relative;
}

.pie-chart {
    width: 100%;
    height: 100%;
    border-radius: 20px;
}
</style>