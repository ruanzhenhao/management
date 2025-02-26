<template>
    <div>
        <div ref="chart" class="chart"></div>
    </div>
</template>

<script>
import { mapState } from 'vuex';
import * as echarts from 'echarts';
import { getNotTask } from '@/api/team';

const COLORS = {
    unfinished: 'rgb(245, 245, 247)', // 未完成或待审批颜色
    completed: 'rgba(0, 162, 255, 1)' // 已完成颜色
};

export default {
    computed: {
        ...mapState(['teamName'])
    },
    name: 'GenderRatioChart',
    data() {
        return {
            chart: null, // 用于保存图表实例
            chartData: {
                unfinished: 0,
                completed: 0
            }
        };
    },
    mounted() {
        this.initChart();
        this.getData(); // 在挂载时获取数据
    },
    methods: {
        async getData() {
            try {
                const res = await getNotTask(this.teamName);
                console.log('请求成功16498');
                console.log(res);
                if (res.code === 200) {
                    // 更新 chartData
                    this.chartData.unfinished = res.data["进行中或任务待审批"];
                    this.chartData.completed = res.data["已完成任务"];
                    this.updateChart(); // 更新图表
                } else {
                    this.$message.error(res.msg || '获取数据失败');
                }
            } catch (error) {
                this.$message.error('请求失败: ' + error.message);
            }
        },
        initChart() {
            this.chart = echarts.init(this.$refs.chart);
            this.setChartOptions(); // 初始化图表选项
            window.addEventListener('resize', this.onResize);
        },
        setChartOptions() {
            const option = {
                tooltip: {
                    trigger: 'item'
                },
                legend: {
                    orient: 'vertical',
                    left: 'left'
                },
                series: [
                    {
                        name: '任务完成率',
                        type: 'pie',
                        radius: ['50%', '70%'], // 设置内外半径，形成环形图
                        itemStyle: {
                            borderRadius: 10 // 设置圆角
                        },
                        data: [
                            { value: this.chartData.unfinished, name: '进行中或任务待审批', itemStyle: { color: COLORS.unfinished } },
                            { value: this.chartData.completed, name: '已完成', itemStyle: { color: COLORS.completed } }
                        ],
                        label: {
                            show: false // 显示标注
                        },

                    }
                ]
            };

            this.chart.setOption(option);
        },
        updateChart() {
            // 更新图表数据
            this.chart.setOption({
                series: [
                    {
                        data: [
                            { value: this.chartData.unfinished, name: '进行中或任务待审批', itemStyle: { color: COLORS.unfinished } },
                            { value: this.chartData.completed, name: '已完成', itemStyle: { color: COLORS.completed } }
                        ]
                    }
                ]
            });
        },
        onResize() {
            if (this.chart) {
                this.chart.resize(); // 处理窗口大小变化
            }
        }
    },
    beforeDestroy() {
        window.removeEventListener('resize', this.onResize); // 清除事件监听器
        if (this.chart) {
            this.chart.dispose(); // 释放图表实例
        }
    }
};
</script>

<style>
.chart {
    width: 100%;
    height: 200px;
}
</style>