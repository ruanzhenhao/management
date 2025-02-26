<template>
    <div ref="chart" class="echart" style="width: 100%; height: 100%;"></div>
</template>

<script>
import * as echarts from 'echarts';
import { mapState } from 'vuex';
import { getComplete } from '@/api/home/taskAndTeamData';

export default {
    data() {
        return {
            chartInstance: null,
            option: {
                color: ['#e17055'], // 设置折线颜色
                tooltip: {
                    trigger: 'axis', // 鼠标悬停触发类型
                    formatter: '{b}<br/>{a}: {c}' // 显示格式
                },
                xAxis: {
                    type: 'category',
                    boundaryGap: false, // 不留空隙
                    data: [], // x 轴数据
                    axisLabel: {
                        rotate: 45 // 旋转标签
                    }
                },
                yAxis: {
                    type: 'value',
                    name: '个人任务完成数' // y 轴名称
                },
                series: [
                    {
                        name: '任务完成数(7日)', // 系列名称
                        type: 'line', // 图表类型
                        data: [], // y 轴数据
                        smooth: true, // 平滑曲线
                        areaStyle: {} // 区域样式
                    }
                ],
                backgroundColor: '#ffffff', // 背景颜色
                animationDuration: 1000 // 动画持续时间
            }
        };
    },
    computed: {
        ...mapState(['id'])
    },
    mounted() {
        this.chartInstance = echarts.init(this.$refs.chart); // 初始化 ECharts 实例
        this.chartInstance.setOption(this.option); // 设置图表配置
        window.addEventListener('resize', this.onResize); // 监听窗口大小变化
        this.getData(); // 获取数据
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
            const res = await getComplete(this.id);
            if (res.code === 200) {
                console.log(res.data);
                this.option.series[0].data = res.data.values;
                this.option.xAxis.data = res.data.days;
                this.chartInstance.setOption(this.option); // 设置更新的选项
            } else {
                this.$message.error(res.msg);
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