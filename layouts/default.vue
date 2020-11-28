<template>
  <v-app>
      <v-app-bar
        fixed
        app
        flat
        color="blue lighten-1"
        elevate-on-scroll
        dark
      >
          <v-toolbar-title
          >
              <b>Image Tampered Detector System</b> v1.0 
          </v-toolbar-title>
      </v-app-bar>
      <v-main>
          <v-container>
              <nuxt />
          </v-container>
      </v-main>
      <v-footer
      app
    >
      <span> DSS Assignment Kelompok 4 &copy; {{ new Date().getFullYear() }}</span>
    </v-footer>
  </v-app>
</template>

<script>
export default {

}
</script>
