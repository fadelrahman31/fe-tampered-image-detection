<template>
    <v-app>
        <v-container>
            <v-layout justify-center align-center>
                <v-container fluid>
                    <h1>Verification Results Status</h1>
                    <p>Berikut merupakan hasil deteksi pada gambar KTP pengguna beserta rekomendasi yang didapatkan</p>
                    <v-spacer></v-spacer>
                    <v-spacer></v-spacer>
                    <v-row
                        justify="center"
                    >
                        <v-col
                            cols="12"
                            md="10"
                            
                        >
                            <v-simple-table>
                                <template>
                                    <thead>
                                        <tr>
                                            <th class="text-center">
                                                <h2>Information</h2>
                                            </th>
                                            <th class="text-center">
                                                <h2>Detail</h2>
                                            </th>                                        
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td>Username</td>
                                            <td>{{ this.username }}</td>
                                        </tr>
                                        <tr>
                                            <td>Nomor KTP</td>
                                            <td>{{ this.uid }}</td>
                                        </tr>
                                        <tr>
                                            <td><i>Output Message</i> Proses Deteksi</td>
                                            <td>{{ this.msg }}</td>
                                        </tr>
                                        <tr>
                                            <td>Probabilitas Hasil Prediksi</td>
                                            <td>{{ this.prob }}</td>
                                        </tr>
                                        <tr>
                                            <td><h3>Hasil Rekomendasi Prediksi</h3></td>
                                            <td><h3>{{ this.pred }}</h3></td>
                                        </tr>                                        
                                    </tbody>
                                </template>
                            </v-simple-table>
                        </v-col>
                    </v-row>
                    <v-spacer></v-spacer>
                    <v-btn
                        text
                        light
                        color="success"
                        @click="goBacktoIndex"
                    >
                        go home
                    </v-btn>
                </v-container>                
            </v-layout>
        </v-container>
    </v-app>
</template>

<script>
export default {
    data: () => ({
        username : '',
        uid : '',
        msg : '',
        pred : '',
        prob : ''
    }),
    methods :{
        goBacktoIndex(){
            this.$router.push({
                  path: '/'
            })
        }
    },
    async mounted() {
        var urlParams = window.location.search
        var urlParams = urlParams.toString()
        var urlParams = urlParams.substring(1)
        console.log(urlParams)

        let params = new URLSearchParams(urlParams)
        
        this.username = params.get('email')
        this.uid = params.get('uid')
        this.msg = params.get('msg')
        this.pred = params.get('pred')
        this.prob = params.get('prob')

        console.log("INI DARI HALAMAN DETECTION")
        console.log(this.username)
        console.log(this.uid)
    }
    
}
</script>