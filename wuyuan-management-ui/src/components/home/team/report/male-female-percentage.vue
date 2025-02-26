<template>
    <div>
        <div ref="chart" class="chart"></div>
    </div>
</template>

<script>
import { mapState } from 'vuex';
import * as echarts from 'echarts';
import { getPercentage } from '@/api/team';

export default {
    computed: {
        ...mapState(['teamName'])
    },
    name: 'GenderRatioChart',
    data() {
        return {
            chart: null, // 初始化 chart 实例
            chartData: {
                maleCount: 0, // 初始化男性数量
                femaleCount: 0 // 初始化女性数量
            }
        };
    },
    mounted() {
        this.initChart();
        this.getData();
    },
    methods: {
        async getData() {
            const res = await getPercentage(this.teamName);
            if (res.code === 200) {
                console.log(res);
                const { 男: maleCount, 女: femaleCount } = res.data;
                this.chartData = { maleCount, femaleCount }; // 更新 chartData
                this.chart.setOption(this.getChartOptions()); // 在获取数据后更新图表
            } else {
                this.$message.error(res.msg);
            }
        },
        getChartOptions() {
            return {
                color: [
                    'rgba(0, 162, 255, 1)', // 男性颜色
                    'rgb(255, 69, 69)'   // 女性颜色
                ],
                tooltip: {
                    trigger: 'item'
                },
                legend: {
                    orient: 'vertical',
                    left: 'left'
                },
                series: [
                    {
                        name: '性别',
                        type: 'pie',
                        radius: ['50%', '70%'],
                        itemStyle: {
                            borderRadius: 10
                        },
                        data: [
                            { value: this.chartData.maleCount, name: '男性' },
                            { value: this.chartData.femaleCount, name: '女性' }
                        ],
                        label: {
                            show: false
                        },
                        emphasis: {
                            itemStyle: {
                                shadowBlur: 10,
                                shadowOffsetX: 0,
                                shadowColor: 'rgba(0, 0, 0, 0.5)'
                            }
                        }
                    }
                ]
            };
        },
        initChart() {
            this.chart = echarts.init(this.$refs.chart);
            this.chart.setOption(this.getChartOptions()); // 初始化时设置空数据
            window.addEventListener('resize', this.chart.resize);
        }
    },
    beforeDestroy() {
        window.removeEventListener('resize', this.chart.resize);
    }
};
</script>

<style>
.chart {
    width: 100%;
    height: 200px;
}
</style>