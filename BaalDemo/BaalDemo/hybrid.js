/**
 * Created by dianwoda on 2018/1/2.
 */



var hybrid = {

}
if (weex.config.env.platform === 'Web') {
    window.Hybrid = hybrid
    if (window.Vue) { // 自动绑定
        // alert(window.Hybrid)
        window.Vue.use(hybrid)
    }
}


export default hybrid