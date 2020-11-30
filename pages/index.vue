<template>
  <v-app>
    <v-container>
        <v-layout justify-center align-center>
            <v-container fluid>
                <h1>Sistem Rekomendasi <i>Tampered Image Detector</i></h1>
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
                                <!-- <input type="file" @change="onFileChanged"> -->
                                <v-file-input
                                  accept="image/*"
                                  chips
                                  label='File Image KTP Pengguna'
                                  show-size
                                  truncate-length="25"
                                  v-model="gambarKTP"
                                  :rules="rulesGambarKTP"
                                ></v-file-input>
                            </v-form>
                        </v-card>
                        <v-btn
                            color="success"
                            class="ma-3"
                            @click="submitForm"
                            :loading="submitting"
                            :disabled= "!valid"
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

// import axios from '@nuxtjs/axios'

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
        rulesGambarKTP: [
            v => !!v
        ],
        preview: null,
        message: '',
        prediction: '',
        probability: '',
      
    }),
    methods: {
        onFileChanged (event) {
            this.gambarKTP = event.target.files[0]
        },
        importImg() {
            
            var preview = document.querySelector('img');
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
        submitForm () {

            const formData = new FormData()
            formData.append('model', 'v2')
            formData.append('img', this.gambarKTP, this.gambarKTP.name)
            //console.log(formData)

            const data = [...formData.entries()]
            console.log("=== INI DARI PAGE INDEX ===")
            console.log(data);

            // Add Params Attribut for Push Page
            // DON'T FORGET TO CHANGE THIS URL

            //TODO : ADD RESPONSE STATUS FROM SERVER TO URL PARAMS

            this.submitting = true;
            
            this.$axios.$post('https://188.166.228.3/api/predictor', formData)
              .then((response)=>{
                    console.log(response)
                    this.message = response['message']
                    this.prediction = response['results']['prediction']
                    this.probability = response['results']['probability']

                    let params = new URLSearchParams()

                    params.set('uid', this.noKtp)
                    params.set('email', this.email)
                    params.set('msg', this.message)
                    params.set('pred', this.prediction)
                    params.set('prob', this.probability)

                    this.$router.push({
                        path: '/detection?' + params.toString()
                    })
                    
              })
              .catch((e)=>{
                  console.log("API Error")
                  console.error(e)
                  this.submitting=true
              })
              .finally(()=>{
                  this.submitting=true
              })
        }
    }
}
</script>
