import 'package:cloud_firestore/cloud_firestore.dart';

class EventModel {
  final String id;
  final String eventImage;
  final String eventName;
  final String eventLocation;
  final String eventDate;
  final String eventTime;
  final String participantsLimit;
  final String eventDescription;
  final List participants;

  EventModel(
      {required this.id,
      required this.eventImage,
      required this.eventName,
      required this.eventLocation,
      required this.eventDate,
      required this.eventTime,
      required this.participantsLimit,
      required this.eventDescription,
      required this.participants});

  toJson() {
    return {
      'ID': id,
      'Event Image': eventImage,
      'Event Name': eventName,
      'Event Location': eventLocation,
      'Event Date': eventDate,
      'Event Time': eventTime,
      'Participants Limit': participantsLimit,
      'Event Description': eventDescription,
      'Participants': participants,
    };
  }

  factory EventModel.fromSnapShot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final eventData = document.data()!;
    return EventModel(
        id: eventData["ID"],
        eventImage: eventData['Event Image'],
        eventName: eventData['Event Name'],
        eventLocation: eventData['Event Location'],
        eventDate: eventData['Event Date'],
        eventTime: eventData['Event Time'],
        participantsLimit: eventData['Participants Limit'],
        eventDescription: eventData['Event Description'],
        participants: eventData['Participants']);
  }
}
