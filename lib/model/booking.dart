class Booking {
  Booking({
    required this.id,
    required this.idProperty,
    required this.cover,
    required this.name,
    required this.location,
    required this.date,
    required this.guest,
    required this.breakfast,
    required this.checkInTime,
    required this.night,
    required this.serviceFee,
    required this.activities,
    required this.totalPayment,
    required this.status,
    required this.isDone,
  });

  final String? id;
  final String? idProperty;
  final String? cover;
  final String? name;
  final String? location;
  final String? date;
  final int? guest;
  final String? breakfast;
  final String? checkInTime;
  final int? night;
  final int? serviceFee;
  final int? activities;
  final int? totalPayment;
  final String? status;
  final bool? isDone;

  factory Booking.fromJson(Map<String, dynamic> json) => Booking(
        id: json["id"],
        idProperty: json["id_Property"],
        cover: json["cover"],
        name: json["name"],
        location: json["location"],
        date: json["date"],
        guest: json["guest"],
        breakfast: json["breakfast"],
        checkInTime: json["check_in_time"],
        night: json["night"],
        serviceFee: json["service_fee"],
        activities: json["activites"],
        totalPayment: json["total_payment"],
        status: json["status"],
        isDone: json["is_done"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_Property": idProperty,
        "cover": cover,
        "name": name,
        "location": location,
        "date": date,
        "guest": guest,
        "breakfast": breakfast,
        "check_in_time": checkInTime,
        "night": night,
        "service_fee": serviceFee,
        "activities": activities,
        "total_payment": totalPayment,
        "status": status,
        "is_done": isDone,
      };
}

Booking get initBooking => Booking(
    id: '',
    idProperty: '',
    cover: '',
    name: '',
    location: '',
    date: '',
    guest: 0,
    breakfast: '',
    checkInTime: '',
    night: 0,
    serviceFee: 0,
    activities: 0,
    totalPayment: 0,
    status: '',
    isDone: false);
