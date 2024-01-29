Class {
	#name : #DuplaGalacticaGameProxy,
	#superclass : #Object,
	#instVars : [
		'game'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'Instance creation' }
DuplaGalacticaGameProxy class >> with: aColorCollection and: aBoard usingToThrow: aDiceShaker winningWhen: aValue using: aCardDealer [

	^ self new
		  initializeWith: aColorCollection
		  and: aBoard
		  usingToThrow: aDiceShaker
		  winningWhen: aValue
		  using: aCardDealer
]

{ #category : #cards }
DuplaGalacticaGameProxy >> apply: aCard [

	game apply: aCard
]

{ #category : #information }
DuplaGalacticaGameProxy >> boxes [

	^ game boxes
]

{ #category : #information }
DuplaGalacticaGameProxy >> cardsInPosetionOf: aPlayerColor [

	^ game cardsInPosetionOf: aPlayerColor
]

{ #category : #information }
DuplaGalacticaGameProxy >> cardsToDeal [

	^ game cardsToDeal
]

{ #category : #information }
DuplaGalacticaGameProxy >> currentPlayer [

	^ game currentPlayer
]

{ #category : #information }
DuplaGalacticaGameProxy >> discardCardsDeskAmount [

	^ game discardCardsDeskAmount
]

{ #category : #information }
DuplaGalacticaGameProxy >> goalLaps [

	^ game goalLaps
]

{ #category : #initialization }
DuplaGalacticaGameProxy >> initializeWith: aColorsCollection and: aBoard usingToThrow: aDiceShaker winningWhen: aValue using: aCardDealer [

	game := DuplaGalacticaGame
		        with: aColorsCollection
		        and: aBoard
		        usingToThrow: aDiceShaker
		        winningWhen: aValue
		        using: aCardDealer
]

{ #category : #information }
DuplaGalacticaGameProxy >> lightYears [

	^ game lightYears
]

{ #category : #movement }
DuplaGalacticaGameProxy >> movePlayer [

	^ game movePlayer
]

{ #category : #information }
DuplaGalacticaGameProxy >> parsecs [

	^ game parsecs
]

{ #category : #information }
DuplaGalacticaGameProxy >> playersBox [

	^ game playersBox
]

{ #category : #information }
DuplaGalacticaGameProxy >> playersLaps [

	^ game playersLaps
]

{ #category : #information }
DuplaGalacticaGameProxy >> playersPositions [

	^ game playersPositions
]

{ #category : #finalization }
DuplaGalacticaGameProxy >> ranking [

	^ game ranking
]

{ #category : #finalization }
DuplaGalacticaGameProxy >> winner [

	^ game winner
]
