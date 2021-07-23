


class TenantModel{
    String name;
  String duration;
  String paidOn;
  String endOn;
  String status;
  String amount;

  TenantModel(
      {this.name,
      this.duration,
      this.endOn,
      this.paidOn,
      this.status,
      this.amount});


       factory TenantModel.fromjson(Map<String, dynamic> json) {
    return TenantModel(
    
        name: json["name"],
        duration: json["duration"],
        endOn: json["endDuration"],
        // paidOn: json["paidOn"],
        
        status: json["status"],
        // amount: json["amount"]
        );
  }
}