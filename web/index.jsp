<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/9/28
  Time: 21:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- Bootstrap CSS -->
<!doctype html>
<html lang="en">
<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <script src="https://unpkg.com/vue/dist/vue.js"></script>
    <script src="https://unpkg.com/element-ui/lib/index.js"></script>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://unpkg.com/element-ui/lib/theme-chalk/index.css">
    <title>Hello, world!</title>
    <style>
            .col-9{
            background-color:rbga(64,158,255,0.5);
            }
    </style>
</head>
<body>
      <div id="promise">
          <div id="container">
              <div class="row">
                  <div class="col-9 col-9-style">

                  </div>
                  <div class="col-3">
                  </div>
              </div>
          </div>
          <div v-for="items in list">
              {{items.bookname}}
          </div>
      </div>
      <script>
          var promise = new Vue({
              el:'#promise',
              data:function(){
                 return{
                     list:[],
                     statusText:'链接错误',
                 }
              },
              mounted:function(){
                  //调用getTest方法并向其传递时间1000ms，并经过1s后执行.then方法；在控制台打印出value
                  //一般来说，调用resolve或reject以后，Promise 的使命就完成了，后继操作应该放到then方法里面，
                  // 而不应该直接写在resolve或reject的后面。所以，最好在它们前面加上return语句，这样就不会有意外。
                  /*例子：new Promise((resolve,reject)=>{
                      return resolve(1);
                      console.log(2);/!*不执行console.log语句前面有return*!/
                  })*/
                  this.getTest(3000).then((value) =>{
                      console.log(1);
                  });
 /*                 then方法返回的是一个新的Promise对象（注意不是原来那个Promiase实例），因此可以采用链式写法，即then方法后面再调用另一个then方法*/
                 
                  /*	this.getMessage().then((value)=>{
                        this.list = value;
                        console.log(value);
                  	},(Error)=>{
                        alert("请求失败");
                  	});*/

                  	this.getMessage("https://www.apiopen.top/novelApi").then((value)=>{
                       this.list = value;
                       console.log(value);
                  	}).then(function(comments){
                       console.log("状态改变成功");
                  	},function(err){
                       alert("状态改变失败");
                  	});
              },
              methods:{
                  getTest:function(ms){
                     return new Promise((resolve,reject)=>{
                         setTimeout(resolve,ms,'done');
                     });
                 },
                  getMessage:function(url){
                      //then方法可以接受两个回调函数作为参数。第一个回调函数是Promise对象的状态变为resolved时调用，
                      // 第二个回调函数是Promise对象的状态变为rejected时调用。
                      //resolve函数的作用是，将Promise对象的状态从“未完成”变为“成功”（即从 pending 变为 resolved），
                      // 在异步操作成功时调用，并将异步操作的结果，作为参数传递出去；
                      // reject函数的作用是，将Promise对象的状态从“未完成”变为“失败”（即从 pending 变为 rejected），
                      // 在异步操作失败时调用，并将异步操作报出的错误，作为参数传递出去。
                      const promise = new Promise(function(resolve,reject){
                          const handler = function(){
                              if (this.readyState !== 4) {
                                  return;
                              }
                              if(this.response.code === 200){
                                   resolve(this.response.data);
                              }
                              else{
                                  reject(new Error(this.statusText));
                              }
                          }
                          const client = new XMLHttpRequest();
                          client.open("post",url);
                          client.responseType = "json";
                          client.setRequestHeader("Accept", "application/json");
                          client.send();
                          client.onreadystatechange = handler;
                      });
                          return promise;
                 },
              }
          })
      </script>

<!-- Optional JavaScript -->
<!-- jQuery first, then Popper.js, then Bootstrap JS -->
      <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" ></script>
      <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
      <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
</body>
</html>
