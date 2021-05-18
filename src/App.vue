<template>
  <div id="app">
    <div class="navbar navbar-dark bg-primary">
      <a class="navbar-brand" href="#"></a>
      <ul class="nav">
        <li class="nav-item pr-4">
          <router-link class="text-white" to="/">Home</router-link> 
        </li>
        <li class="nav-item">
          <router-link class="text-white" to="/About">File search</router-link> 
        </li>
        <li class="nav-item">
          <router-link class="nav-link text-white" to="/login">Login</router-link>
        </li>
        <li class="nav-item">
          <router-link class="nav-link text-white" to="/fileupload">Fileupload Page</router-link>
        </li>
      </ul>    
    </div>
    <div class="container">
      <router-view/>

    </div>
    
  </div>
</template>

<style lang="scss">
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
}

#nav {
  padding: 30px;

  a {
    font-weight: bold;
    color: #2c3e50;

    &.router-link-exact-active {
      color: #42b983;
    }
  }
}
</style>
