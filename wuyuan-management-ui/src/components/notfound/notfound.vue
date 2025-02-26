<template>
    <div>
        <img src="@/assets/image/404.png" class="notfountimg">
        <div class="notfount">
            <el-button type="warning" plain @click="goToLogin">返回登录页面</el-button>
        </div>
    </div>
</template>

<script>
export default {
    methods:
    {
        goToLogin()
        {
            this.$router.push({name:'login'})
        }
    }
};
</script>

<style scoped>
.notfount{
   
    
    position: absolute;
    left: 50%;
    top: 80%;
    transform: translate(-50%, -50%);
    
    
}
.notfountimg{
    position: absolute;
    left: 50%;
    top: 45%;
    transform: translate(-50%, -50%);
}
</style>