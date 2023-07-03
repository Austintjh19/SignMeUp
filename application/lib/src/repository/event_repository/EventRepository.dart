import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapplication/src/models/EventModel.dart';

class EventRepository extends GetxController {
  static EventRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<String?> createEvent(EventModel event, String eventID) async {
    try {
      await _db
          .collection('EventsInfo')
          .doc(eventID)
          .set(event.toJson())
          .whenComplete(() => Get.snackbar(
              "Success", "Event Succefully Created",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.green.withOpacity(0.1),
              colorText: Colors.green))
          .catchError((error, StackTrace) {
        Get.snackbar("Error", "An error has occured. Please retry.",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.redAccent.withOpacity(0.1),
            colorText: Colors.red);
      });
      return event.id;
    } catch (e) {
      Get.snackbar("Error", e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          colorText: Colors.red);
    }
  }

  Future<List<EventModel>> getSelectedEvents(List registeredEvents) async {
    List<EventModel> registeredEventsCollection = [];
    if (registeredEvents.isEmpty) {
      return registeredEventsCollection;
    }
    QuerySnapshot querySnapshot = await _db
        .collection('EventsInfo')
        .where("ID", whereIn: registeredEvents)
        .orderBy('EventDateTime', descending: false)
        .get();

    querySnapshot.docs.forEach((element) {
      registeredEventsCollection.add(EventModel.fromSnapShot(
          element as DocumentSnapshot<Map<String, dynamic>>));
    });
    return registeredEventsCollection;
  }

  Future<List<EventModel>> getAllFilteredEvents(
      String filterBy, bool isDescending) async {
    QuerySnapshot querySnapshot = await _db
        .collection('EventsInfo')
        .orderBy(filterBy, descending: isDescending)
        .get();
    List<EventModel> eventsCollection = [];
    querySnapshot.docs.forEach((element) {
      eventsCollection.add(EventModel.fromSnapShot(
          element as DocumentSnapshot<Map<String, dynamic>>));
    });
    return eventsCollection;
  }

  Future<List<EventModel>> searchEvent(
      String query, String filterBy, bool isDescending) async {
    List<EventModel> eventsCollection = [];
    QuerySnapshot nameQuerySnapshot = await _db
        .collection('EventsInfo')
        .orderBy(filterBy, descending: isDescending)
        .where('Event Name', arrayContains: query)
        .get();
    nameQuerySnapshot.docs.forEach((element) {
      eventsCollection.add(EventModel.fromSnapShot(
          element as DocumentSnapshot<Map<String, dynamic>>));
    });
    QuerySnapshot locationQuerySnapshot = await _db
        .collection('EventsInfo')
        .orderBy(filterBy, descending: isDescending)
        .where('Event Location', arrayContains: query)
        .get();
    locationQuerySnapshot.docs.forEach((element) {
      eventsCollection.add(EventModel.fromSnapShot(
          element as DocumentSnapshot<Map<String, dynamic>>));
    });
    return eventsCollection;
  }

  Future<String> getEventImage(String imagePath) async {
    if (imagePath != "") {
      Reference ref = FirebaseStorage.instance.ref().child(imagePath);
      final imageURL = await ref.getDownloadURL();
      return imageURL;
    }
    return "";
  }

  Future<void> addParticipant(String uid, String eventID) async {
    await _db.collection('EventsInfo').doc(eventID).update({
      'Participants': FieldValue.arrayUnion([uid])
    });
  }

  Future<void> removeParticipant(String uid, String eventID) async {
    await _db.collection('EventsInfo').doc(eventID).update({
      'Participants': FieldValue.arrayRemove([uid])
    });
  }

  Future<void> updateEventsCollection() async {
    List<EventModel> outdatedEvents = [];
    QuerySnapshot snapshot = await _db
        .collection('EventsInfo')
        .where('EventDateTime',
            isLessThan:
                DateTime.now().subtract(const Duration(days: 1)).toUtc())
        .get();
    snapshot.docs.forEach((element) {
      outdatedEvents.add(EventModel.fromSnapShot(
          element as DocumentSnapshot<Map<String, dynamic>>));
    });
  }

  Future<void> removeEvents(String EventID) async {}
}
