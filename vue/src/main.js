import '@/assets/main.css' // 引入 main.css 样式文件
import {createApp} from 'vue' // 引入 createApp 方法
import App from '@/App.vue' // 引入 App.vue 组件
import router from '@/router' // 导入路由
import * as ElementPlusIconsVue from '@element-plus/icons-vue' // 导入 Element Plus 图标


const app = createApp(App)

app.use(router) // 应用路由
app.mount('#app')

for (const [key, component] of Object.entries(ElementPlusIconsVue)) { // 引入图标
    app.component(key, component)
}


