import 'dart:convert';

Ticketclass ticketclassFromJson(String str) => Ticketclass.fromJson(json.decode(str));

String ticketclassToJson(Ticketclass data) => json.encode(data.toJson());

class Ticketclass {
  Data data;

  Ticketclass({
    this.data,
  });

  factory Ticketclass.fromJson(Map<String, dynamic> json) => Ticketclass(
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
  };
}

class Data {
  String authToken;
  List<Ticket> tickets;
  bool success;
  String status;

  Data({
    this.authToken,
    this.tickets,
    this.success,
    this.status,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    authToken: json["auth_token"],
    tickets: List<Ticket>.from(json["tickets"].map((x) => Ticket.fromJson(x))),
    success: json["success"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "auth_token": authToken,
    "tickets": List<dynamic>.from(tickets.map((x) => x.toJson())),
    "success": success,
    "status": status,
  };
}

class Ticket {
  int id;
  String title;
  int userId;
  DateTime createdAt;
  List<Inquiry> inquiries;

  Ticket({
    this.id,
    this.title,
    this.userId,
    this.createdAt,
    this.inquiries,
  });

  factory Ticket.fromJson(Map<String, dynamic> json) => Ticket(
    id: json["id"],
    title: json["title"] == null ? null : json["title"],
    userId: json["user_id"],
    createdAt: DateTime.parse(json["created_at"]),
    inquiries: List<Inquiry>.from(json["inquiries"].map((x) => Inquiry.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title == null ? null : title,
    "user_id": userId,
    "created_at": createdAt.toIso8601String(),
    "inquiries": List<dynamic>.from(inquiries.map((x) => x.toJson())),
  };
}

class Inquiry {
  int id;
  String message;
  DateTime createdAt;
  dynamic images;
  int ticketId;

  Inquiry({
    this.id,
    this.message,
    this.createdAt,
    this.images,
    this.ticketId,
  });

  factory Inquiry.fromJson(Map<String, dynamic> json) => Inquiry(
    id: json["id"],
    message: json["message"] == null ? null : json["message"],
    createdAt: DateTime.parse(json["created_at"]),
    images: json["images"],
    ticketId: json["ticket_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "message": message == null ? null : message,
    "created_at": createdAt.toIso8601String(),
    "images": images,
    "ticket_id": ticketId,
  };
}
