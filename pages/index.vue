<template>
  <v-app>
    <v-container>
        <v-layout justify-center align-center>
            <v-container fluid>
                <h1>Selamat datang!</h1>
                <p>Masukkan gambar KTP yang hendak diperiksa oleh sistem! </p>
                <v-row
                    justify="center"
                >
                    <v-spacer></v-spacer>
                    <v-col
                        cols="12"
                        md="6"
                    >
                        <v-card
                            class="pa-5"
                            flat
                        >
                            <v-form
                                ref= "form"
                                v-model= "valid"
                            >
                                <h3>Masukkan username pengguna</h3>
                                <v-text-field
                                    v-model= "email"
                                    :counter= "100"
                                    :rules= "rulesEmail"
                                    label= "Username Pengguna"
                                    required
                                ></v-text-field>
                                <h3>Masukkan nomor KTP pengguna</h3>
                                <v-text-field
                                    v-model= "noKtp"
                                    :counter= "200"
                                    :rules= "rulesNoKtp"
                                    label= "Nomor KTP Pengguna"
                                    required
                                ></v-text-field>
                                <h3>Upload gambar KTP pengguna</h3>
                                <v-file-input
                                  accept="image/*"
                                  chips
                                  label='File Image KTP Pengguna'
                                  show-size
                                  truncate-length="25"
                                  v-model="gambarKTP"
                                ></v-file-input>
                            </v-form>
                        </v-card>
                        <v-btn
                            color="success"
                            class="ma-3"
                            @click="submitForm"
                            :loading="submitting"
                        >detect now</v-btn>
                        <v-btn
                            class="ma-3"
                            color='grey'
                            @click="importImg"
                        >preview image</v-btn>
                    </v-col>
                    <v-spacer></v-spacer>
                    <v-col
                        cols="12"
                        md="6"
                    >
                        <v-card
                            class="mx-auto"
                            raised
                        >
                            <v-img>
                              <img src="" height="300px" alt="Image preview...">  
                            </v-img>
                            <v-card-title>
                                Preview Gambar KTP
                            </v-card-title>                            
                        </v-card>
                    </v-col>
                </v-row>
            </v-container>
        </v-layout>
    </v-container>
  </v-app>
</template>

<script>

import axios from '@nuxtjs/axios'

export default {
    data: () => ({
        valid: true,
        submitting: false,
        email: '',
        rulesEmail: [
            v => !!v || 'Username is required',
            v => (v && v.length <= 200) || 'Nama must be less than 200 characters'
        ],
        noKtp: '',
        rulesNoKtp: [
            v => !!v || 'Nomor KTP is required',
            v => (v && v.length <= 100) || 'Alamat must be less than 100 characters'
        ],
        gambarKTP: null,
        preview: null
    }),
    methods: {
        importImg() {
            
            var preview = document.querySelector('img');
            //const file = document.querySelector('input[type=file]').files[0];
            var file = this.gambarKTP;
            var reader = new FileReader();
            var a = null;

            reader.addEventListener("load", function () {
              // convert image file to base64 string
              preview.src = reader.result;
              
            }, false);

            if (file) {
              reader.readAsDataURL(file);
            }


            //console.log(file)
        },
        replaceStr (){
            let a = this.fasilitas0
            let b = JSON.stringify(a)
            b = b.replace(/"/g,"'")
            this.fasilitas = b
        },
        generateID (len, arr){
            var ans = ''
            for (var i = len; i>0; i-- ){
                ans +=
                    arr[Math.floor(Math.random()* arr.length)]
            }
            return ans
        },
        submitForm () {
            //this.$axios.post('',)
            // this.replaceStr()
            // let idKost = this.generateID(8,'12345abcdefxzpqi')
            // var postQuery = {
            //     id              : idKost,
            //     nama            : this.nama,
            //     alamat          : this.alamat,
            //     fasilitas       : this.fasilitas,
            //     harga           : this.harga,
            //     gambar          : this.gambar
            // }


            const formData = new FormData()
            formData.append('model', 'v2')
            formData.append('img', this.gambarKTP)
            const data = [...formData.entries()]
            console.log(data);

            // Add Params Attribut for Push Page
            // DON'T FORGET TO CHANGE THIS URL

            let url = new URL("http://localhost:3000")
            let params = new URLSearchParams(url.search)

            params.set('uid', this.noKtp)
            params.set('email', this.email)
            console.log(params.toString())
            
            console.log(params.get('email'))
            console.log(params.get('uid'))

            this.$router.push({
                  path: '/detection?' + params.toString()
                })

            //TODO : ADD RESPONSE STATUS FROM SERVER TO URL PARAMS

            // this.submitting = true;
            // this.$axios.post('/api/indekos/info',postQuery)
            //   .then((response)=>{
            //     this.$router.push({
            //       path: '/'
            //     })
            //   })
            //   .catch((e)=>{
            //     console.error(e)
            //   })
            //   .finally(() => {
            //     this.submitting = true;
            //   })
        }
    }
}
</script>
