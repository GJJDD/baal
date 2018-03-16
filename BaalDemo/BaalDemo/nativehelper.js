<script src="http://prodwbbucket.oss-cn-hangzhou.aliyuncs.com/weex/rider/node_modules/vue/vue.min.js"></script>
<script src="http://prodwbbucket.oss-cn-hangzhou.aliyuncs.com/weex/rider/node_modules/weex-vue-render/index.min.js"></script>
module = {
init: function (weex) {
    weex.registerModule('guide', {
                        greeting () {
                        const modal = weex.requireModule('modal');
                        modal.toast({
                                    message: '傻逼傻吧',
                                    duration: 3
                                    });
                        },
                        farewell () {
                        console.log('Goodbye, I am always at your service.')
                        }
                        })
    
}
}
weex.install(module);

