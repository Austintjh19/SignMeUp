import 'package:cloud_firestore/cloud_firestore.dart';

class EventModel {
  final String? id;
  final String eventImage;
  final String eventName;
  final String eventLocation;
  final String eventDate;
  final String eventTime;
  final String partcipantsLimit;
  final String eventDescription;
  final Set participants;

  EventModel(
      {this.id,
      required this.eventImage,
      required this.eventName,
      required this.eventLocation,
      required this.eventDate,
      required this.eventTime,
      required this.partcipantsLimit,
      required this.eventDescription,
      required this.participants});

  toJson() {
    return {
      'Event Image': eventImage,
      'Event Name': eventName,
      'Event Location': eventLocation,
      'Event Date': eventDate,
      'Event Time': eventTime,
      'Participants Limit': partcipantsLimit,
      'Event Description': eventDescription,
      'Participants': participants,
    };
  }

  factory EventModel.fromSnapShot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final eventData = document.data()!;
    return EventModel(
        eventImage: eventData['Event Image'],
        eventName: eventData['Event Name'],
        eventLocation: eventData['Event Location'],
        eventDate: eventData['Event Date'],
        eventTime: eventData['Event Time'],
        partcipantsLimit: eventData['Participants Limit'],
        eventDescription: eventData['Event Description'],
        participants: eventData['Participants']);
  }
}
