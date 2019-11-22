class CustomError {
  
  final String errorMsg; 
  final bool status; 

  CustomError({this.errorMsg, this.status});

   factory CustomError.fromJson(Map<String,dynamic> json) {
    return CustomError(
      errorMsg: json['errorMsg'], 
      status: json['status'],
    );
   }
}