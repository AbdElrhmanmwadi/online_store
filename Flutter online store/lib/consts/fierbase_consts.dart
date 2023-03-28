import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore firestore = FirebaseFirestore.instance;
User? currerntuser = auth.currentUser;
const usercollection = 'users';
const productCollection = 'products';
const Cart = 'Cart';
const chatcollection = 'chats';
const messagecolection = 'message';
const ordersCollection = 'orders';
