//modeling Event
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class EventModel {
  final String id;
  final String eventOrganizer;
  final String eventImage;
  final List eventName;
  final List eventLocation;
  final String eventDate;
  final String eventTime;
  final DateTime eventDateTime;
  final String participantsLimit;
  final String eventDescription;
  final List participants;
  final int numParticipants;
  final bool isFull;

  EventModel(
      {required this.id,
      required this.eventOrganizer,
      required this.eventImage,
      required this.eventName,
      required this.eventLocation,
      required this.eventDate,
      required this.eventTime,
      required this.eventDateTime,
      required this.participantsLimit,
      required this.eventDescription,
      required this.participants,
      required this.numParticipants,
      required this.isFull});

  toJson() {
    return {
      'ID': id,
      'Event Organizer': eventOrganizer,
      'Event Image': eventImage,
      'Event Name': eventName,
      'Event Location': eventLocation,
      'Event Date': eventDate,
      'Event Time': eventTime,
      'EventDateTime': eventDateTime,
      'Participants Limit': participantsLimit,
      'Event Description': eventDescription,
      'Participants': participants,
      'Num Participants': numParticipants,
      'Is Full?': isFull,
    };
  }

  factory EventModel.fromSnapShot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final eventData = document.data()!;
    return EventModel(
        id: eventData["ID"],
        eventOrganizer: eventData['Event Organizer'],
        eventImage: eventData['Event Image'],
        eventName: eventData['Event Name'],
        eventLocation: eventData['Event Location'],
        eventDate: eventData['Event Date'],
        eventTime: eventData['Event Time'],
        eventDateTime: DateFormat("EEEE, MMM d, yyyy HH:mm")
            .parse('${eventData['Event Date']} ${eventData['Event Time']}'),
        participantsLimit: eventData['Participants Limit'],
        eventDescription: eventData['Event Description'],
        participants: eventData['Participants'],
        numParticipants: eventData['Num Participants'],
        isFull: eventData['Is Full?']);
  }
}
