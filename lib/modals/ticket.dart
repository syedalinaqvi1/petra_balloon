class Ticket {
  final String selectedPass;
  final int ticketNumber;
  final String passenger;
  final String date;
  Ticket(this.selectedPass, this.ticketNumber, this.passenger, this.date);

  // named constructor
  factory Ticket.fromJson(Map<String, dynamic> json) {
    return Ticket(json['selected_pass'] as String, json['ticketNumber'] as int,
        json['Passenger'] as String, json['Date'] as String);
  }

  // method
  Map<String, dynamic> toJson() {
    return {
      'selected_pass': selectedPass,
      'ticketNumber': ticketNumber,
      'Passenger': passenger,
      'Date': date
    };
  }
}
