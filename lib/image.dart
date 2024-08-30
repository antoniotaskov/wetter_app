String getImage(String wetterHauptzustand) {
  switch (wetterHauptzustand.toLowerCase()) {
    case 'clear':
      return 'assets/image/klarer_himmel.jpg'; // Klarer Himmel
    case 'clouds':
      return 'assets/image/bewoelkt.jpg'; // Bewölkt
    case 'rain':
      return 'assets/image/regen.jpg'; // Regen
    case 'snow':
      return 'assets/image/schnee.jpg'; // Schnee
    case 'thunderstorm':
      return 'assets/image/gewitter.jpg'; // Gewitter
    case 'drizzle':
      return 'assets/image/nieselregen.jpg'; // Nieselregen
    case 'fog':
    case 'mist':
    case 'haze':
      return 'assets/image/nebel.jpg'; // Nebel oder Dunst
    default:
      return 'assets/image/standard.jpg'; // Standardbild
  }
}
