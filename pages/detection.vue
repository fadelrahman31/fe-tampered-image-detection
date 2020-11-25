<template>
    <v-app>
        <h1>Verification Status</h1>
        <h2>{{ this.uid }}</h2>
        <h2>{{ this.username }}</h2>
    </v-app>
</template>

<script>
export default {
    data: () => ({
        uid : null,
        username : null
    }),
    async mounted() {
        var urlParams = window.location.search
        var urlParams = urlParams.toString()
        var urlParams = urlParams.substring(1)
        console.log(urlParams)

        let params = new URLSearchParams(urlParams)
        this.uid = params.get('uid')
        this.username = params.get('email')
        // console.log("INI DARI HALAMAN DETECTION")
        // console.log(params.get('uid'))
        // console.log(params.get('email'))
    }
    
}
</script>