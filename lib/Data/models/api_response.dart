//Objet representant une reponse de l'API
class ApiResponse<T> {
  final bool success;
  final T? data;
  final String? error;

  //On effectue un test-unitaire au constructeur
  // Requete réussie pas d'erreur et nous avons des données OK
  // Si pas de succès de la requête suivie d'erreur et pas de données OK
  ApiResponse({this.success = true, this.data, this.error}): assert(
  (success && error == null && data != null) ||
      (!success && error != null && data == null),
  );
}