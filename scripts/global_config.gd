extends Resource
class_name GlobalConfig

## Sollen Pilze auch ohne Dünger wachsen können
@export var grow_without_fertilizer : bool = false

@export_category("Pick Up")
## Soll der Spieler nur maximal 1 Item Tragen dürfen
@export var player_carry_only_one_item : bool = true
## Wie lange soll es dauern ein Objekt hoch zu heben
@export var pickup_time : float = 0.3

@export_category("Grow Time")
@export_group("Common")
## Wie lange in Sekunden brauchen Common Pilze zum erreichen des mittleren Wachstumsstadiums
@export var common_mushroom_grow_time_stage_1 : float = 1.0
## Wie lange in Sekunden brauchen Common Pilze um vom mittleren ins endgültige Wachstumsstadium zu wechseln
@export var common_mushroom_grow_time_stage_2 : float = 1.0
@export_group("Rare")
## Wie lange in Sekunden brauchen Common Pilze zum erreichen des mittleren Wachstumsstadiums
@export var rare_mushroom_grow_time_stage_1 : float = 5.0
## Wie lange in Sekunden brauchen Common Pilze um vom mittleren ins endgültige Wachstumsstadium zu wechseln
@export var rare_mushroom_grow_time_stage_2 : float = 5.0
@export_group("Ultra Rare")
## Wie lange in Sekunden brauchen Common Pilze zum erreichen des mittleren Wachstumsstadiums
@export var ultra_rare_mushroom_grow_time_stage_1 : float = 10.0
## Wie lange in Sekunden brauchen Common Pilze um vom mittleren ins endgültige Wachstumsstadium zu wechseln
@export var ultra_rare_mushroom_grow_time_stage_2 : float = 10.0

@export_category("Customer")
## Ob Kunden nur den gewünschten Pilz kaufen
@export var customers_only_accept_requested : bool = false

@export_category("Money")
## Wie viel Geld ein Pilz der Seltenheit Common gibt
@export var money_common_mushroom : int = 5
## Wie viel Geld ein Pilz der Seltenheit Rare gibt
@export var money_rare_mushroom : int = 10
## Wie viel Geld ein Pilz der Seltenheit Ultra Rare gibt
@export var money_ultra_rare_mushroom : int = 20
## In Prozent wieviel Geld es für den falschen Pilz gibt
@export var money_percent_wrong_mushroom : float = 33
