<template>
    <div ref="chart" class="echart" style="width: 100%; height: 100%;"></div>
</template>

<script>
import * as echarts from 'echarts';
import { getTaskType } from '@/api/home/taskAndTeamData'
import { mapState } from 'vuex';
export default {

    data() {
        return {
            chartInstance: null,
            option: {
                tooltip: {

                    trigger: 'item' // 工具提示框触发类型为“item”
                },
                legend: {
                    top: '5%', // 图例的位置在容器的顶部，距离顶部 5%
                    left: 'center' // 图例水平居中
                },
                series: [
                    {
                        name: '任务状态统计', // 系列名称
                        type: 'pie', // 图表类型为饼图
                        radius: ['40%', '70%'], // 饼图的内半径和外半径
                        avoidLabelOverlap: false, // 是否避免标签重叠
                        itemStyle: {

                            borderRadius: 10, // 每个扇区的圆角
                            borderColor: '#fff', // 扇区边框颜色
                            borderWidth: 2 // 扇区边框宽度
                        },
                        label: {
                            show: false, // 默认不显示标签
                            position: 'center' // 标签位置设置在中心
                        },
                        emphasis: {
                            label: {
                                show: true, // 鼠标悬停时显示标签
                                fontSize: 30, // 悬停时标签字体大小
                                fontWeight: 'bold' // 悬停时标签字体加粗
                            }
                        },
                        labelLine: {
                            show: false // 不显示标签连线
                        },
                        data: []
                    }
                ]
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
            console.log(this.teamId);
            const res = await getTaskType(this.teamId);
            if (res.code === 200) {
                console.log(res.data);
                this.option.series[0].data = res.data;
                this.option.series[0].itemStyle.color = (params) => {
                    const colors = ['#e17055', '#fab1a0', '#ffeaa7', '#fdcb6e'];
                    return colors[params.dataIndex % colors.length]; // 循环使用颜色
                };
                this.chartInstance.setOption(this.option); // 设置更新的选项
            } else {
                this.$message.error(res.msg);
            }

        }
    }
};
</script>

<style lang="less" scoped></style>