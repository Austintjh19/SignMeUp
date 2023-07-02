//modeling Event 
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class EventModel {
  final String id;
  final String eventImage;
  final List eventName;
  final List eventLocation;
  final String eventDate;
  final String eventTime;
  final DateTime eventDateTime;
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
      required this.eventDateTime,
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
      'EventDateTime': eventDateTime,
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
        eventDateTime: DateFormat("EEEE, MMM d, yyyy HH:mm")
            .parse('${eventData['Event Date']} ${eventData['Event Time']}'),
        participantsLimit: eventData['Participants Limit'],
        eventDescription: eventData['Event Description'],
        participants: eventData['Participants']);
  }
}


// var lst = ["element1" , "element2" , "element3"];
// lst.last // -> element3

// setSearchParameters(String name) {
        // List<String> searchOptions = [];
        // String temp = "";
        // for (int i = 0; i < name.length; i++) {
        //   temp = temp + name[i];
        //   searchOptions.add(temp);
        // }
        // return searchOptions;
//   }
