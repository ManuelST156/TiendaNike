class Shoe {
  final int id;
  final String name;
  final String description;
  final double price;
  final String imagePath;

  Shoe({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imagePath,
  });

  factory Shoe.fromJson(Map<String, dynamic> json) => Shoe(
        id: json["idProducto"],
        name: json["Nombre"],
        description: json["Descripcion"],
        price: json["Precio"],
        imagePath: json["imagePath"] ??
            '', // Asumiendo que tienes una imagen por defecto o un campo en la BD
      );

  Map<String, dynamic> toJson() => {
        "idProducto": id,
        "Nombre": name,
        "Descripcion": description,
        "Precio": price,
        "imagePath": imagePath,
      };
}
