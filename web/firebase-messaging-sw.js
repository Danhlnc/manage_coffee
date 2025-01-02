// Please see this file for the latest firebase-js-sdk version:
// https://github.com/firebase/flutterfire/blob/master/packages/firebase_core/firebase_core_web/lib/src/firebase_sdk_version.dart
importScripts("https://www.gstatic.com/firebasejs/10.7.0/firebase-app-compat.js");
importScripts("https://www.gstatic.com/firebasejs/10.7.0/firebase-messaging-compat.js");
const firebaseConfig = {
    apiKey: "AIzaSyCqhlzi8IPAH_KndOBzIw69gPeVBUIzNi4",
    authDomain: "tscoffee-8eaab.firebaseapp.com",
    projectId: "tscoffee-8eaab",
    storageBucket: "tscoffee-8eaab.firebasestorage.app",
    messagingSenderId: "411658702585",
    appId: "1:411658702585:web:f63d8ba2939f84b0f31c28",
    measurementId: "G-LTN9BR0W4B"
  };
firebase.initializeApp(firebaseConfig);

const messaging = firebase.messaging();

// Optional:
messaging.onBackgroundMessage((message) => {
  console.log("onBackgroundMessage", message);
});