<template>
    <div class="editor">
        <el-breadcrumb separator="/" class="breadcrumb">
            <el-breadcrumb-item :to="{ path: '/api/admin/home/user' }">首页</el-breadcrumb-item>
            <el-breadcrumb-item><a href="/#/api/admin/home/user/info">个人信息</a></el-breadcrumb-item>
            <el-breadcrumb-item>编辑</el-breadcrumb-item>
        </el-breadcrumb>
        <div class="changeData">
            <el-form :model="formData" label-width="100px" @submit.native.prevent="submitForm">
                <el-form-item label="头像">
                    <div class="avatar-container" @click="changeHeadshot">
                        <el-avatar shape="square" :size="60" :src="require('@/' + formData.img)"
                            class="clickable-avatar" v-if="formData.img"></el-avatar>
                        <div class="avatar-label">点击更换头像</div>
                    </div>
                </el-form-item>
                <el-form-item label="用户名">
                    <el-input v-model="formData.username" placeholder="请输入用户名" class="short-input" required></el-input>
                </el-form-item>
                <el-form-item label="姓名">
                    <el-input v-model="formData.name" placeholder="请输入姓名" class="short-input" required></el-input>
                </el-form-item>
                <el-form-item label="电话">
                    <el-input v-model="formData.phone" placeholder="请输入电话" class="short-input" required></el-input>
                </el-form-item>
                <el-form-item label="性别">
                    <el-select v-model="formData.sex" placeholder="请选择性别" class="short-input" required>
                        <el-option label="男" value="男"></el-option>
                        <el-option label="女" value="女"></el-option>
                    </el-select>
                </el-form-item>
                <el-form-item label="身份证号">
                    <el-input v-model="formData.idNumber" placeholder="请输入身份证号" class="short-input" required></el-input>
                </el-form-item>
                <el-form-item label="邮箱">
                    <el-input v-model="formData.email" placeholder="请输入邮箱" class="short-input" required></el-input>
                </el-form-item>
                <el-form-item label="爱好">
                    <el-input v-model="formData.hobby" placeholder="请输入爱好" type="textarea" class="large-textarea"
                        rows="4"></el-input>
                </el-form-item>
                <el-form-item>
                    <el-button type="primary" @click="submitForm">提交</el-button>
                    <el-button @click="outset">重置</el-button>
                </el-form-item>
            </el-form>
        </div>
        <el-dialog title="更换头像" :visible.sync="changeHeadshotShow" width="30%">
            <div>
                <el-scrollbar>
                    <el-row :gutter="20" class="img-row">
                        <el-col class="img-col" :xs="8" :sm="6" :md="4" :lg="4" :xl="3" v-for="item in imageUrls"
                            :key="item.id">
                            <el-avatar :size="50" :src="require('@/' + item.url)" :class="{ 'selected': item.selected }"
                                @click.native="selectAvatar(item)">
                            </el-avatar>
                        </el-col>
                    </el-row>
                </el-scrollbar>
            </div>
            <div slot="footer">
                <el-button @click.native='cancel()'>取 消</el-button>
                <el-button type="primary" @click="changeFormHeadshot">确 定</el-button>
            </div>
        </el-dialog>
    </div>
</template>

<script>
import { changeUser, getUser } from '@/api/home/user';
import { updateHeadshot } from '@/api/home/user';

export default {
    data() {
        return {
            imageUrls: [
                { id: 2, url: 'assets/headshot/type2.jpg', selected: false },
                { id: 3, url: 'assets/headshot/type3.jpg', selected: false },
                { id: 4, url: 'assets/headshot/type4.jpg', selected: false },
                { id: 5, url: 'assets/headshot/type5.jpg', selected: false },
                { id: 6, url: 'assets/headshot/type6.jpg', selected: false },
                { id: 7, url: 'assets/headshot/type7.jpg', selected: false },
                { id: 8, url: 'assets/headshot/type8.jpg', selected: false },
                { id: 9, url: 'assets/headshot/type9.jpg', selected: false },
                { id: 10, url: 'assets/headshot/type10.jpg', selected: false },
                { id: 11, url: 'assets/headshot/type11.jpg', selected: false }
            ],
            changeHeadshotShow: false,
            formData: {
                img: '', // 初始化为空字符串或默认路径
                username: '',
            },
        };
    },
    methods: {
        cancel() {
            this.changeHeadshotShow = false;
            this.outset();
        },
        async outset() {
            const res = await getUser(this.$store.state.id);
            if (res.code === 200) {
                this.formData = res.data;
                if (!this.formData.img) {
                    this.formData.img = '@/assets/headshot/type11.jpg';
                }
            } else {
                this.$message({ message: res.msg, type: 'error' });
            }
        },
        changeHeadshot() {
            this.changeHeadshotShow = true;
        },
        selectAvatar(item) {
            // 更新头像选择逻辑
            this.imageUrls.forEach(img => { img.selected = false; });
            item.selected = true;
            this.formData.img = item.url; // 更新 formData.img
        },
        async changeFormHeadshot() {
            this.changeHeadshotShow = false;
            const updatedData = {
                id: this.$store.state.id,
                img: this.formData.img
            };
            await updateHeadshot(updatedData);
            this.$store.commit('changeimg', this.formData.img);
            this.$message({ message: '更换成功', type: 'success' });
        },
        async submitForm() {
            const res = await changeUser(this.formData);
            if (res.code === 200) {
                this.$message({ message: '更换成功', type: 'success' });
            } else {
                this.$message({ message: res.msg, type: 'error' });
            }
            this.outset();
        }
    },
    mounted() {
        this.outset();
    }
};
</script>

<style scoped>
.editor {
    width: 90%;
    height: 80%;
    padding: 20px;
    background-color: #f6f7fb;
}

.breadcrumb {
    margin-bottom: 20px;
    font-size: 14px;
}

.changeData {
    padding: 20px;
    background-color: #ffffff;
    border-radius: 8px;
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
}

.avatar-container {
    display: flex;
    align-items: center;
    cursor: pointer;
}

.avatar-label {
    margin-left: 10px;
    font-size: 14px;
    color: #409EFF;
}

.el-form-item {
    margin-bottom: 15px;
}

.short-input {
    width: 280px;
}

.large-textarea {
    width: 100%;
    max-width: 400px;
}

.el-input,
.el-select {
    border-radius: 4px;
    background-color: #f5f5f5;
    border: 1px solid #dcdfe6;
    transition: border-color 0.3s;
}

.el-input:hover,
.el-select:hover,
.el-input:focus,
.el-select:focus {
    border-color: #409EFF;
}

.el-button {
    margin-right: 10px;
    border-radius: 4px;
}

.el-button.primary {
    background-color: #409EFF;
    color: #fff;
}

.el-button.primary:hover {
    background-color: #66b1ff;
}

.img-row {
    margin: 0;
    padding: 0;
}

.img-col {
    margin: 5px;
    padding: 5px;
}

.selected {
    border: 2px solid #409EFF !important;
    box-shadow: 0 0 10px rgba(64, 158, 255, 0.5) !important;
}
</style>