import '@/assets/main.css' // 引入 main.css 样式文件
import {createApp} from 'vue' // 引入 createApp 方法
import App from '@/App.vue' // 引入 App.vue 组件
import router from '@/router' // 导入路由

const app = createApp(App)

// 应用路由
app.use(router)
app.mount('#app')