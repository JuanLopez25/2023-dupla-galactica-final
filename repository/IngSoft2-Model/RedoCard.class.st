Class {
	#name : #RedoCard,
	#superclass : #Object,
	#instVars : [
		'redoing'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
RedoCard >> applyCardUsing: cardManager at: aGame to: anObjective [

	cardManager lastCardPlay isEmpty
		ifFalse: [ 
			redoing := cardManager lastCardPlay.
			^ cardManager lastCardPlay
				  applyCardUsing: cardManager
				  at: aGame
				  to: anObjective ]
		ifTrue: [ 
			Error signal:
				'Redo card cannot be played because there are no cards that have been played before' ]
]

{ #category : #card }
RedoCard >> applyEffect [

	^ redoing applyEffect
]

{ #category : #information }
RedoCard >> hasEffect [

	^ false
]

{ #category : #information }
RedoCard >> isEmpty [

	^ false
]

{ #category : #information }
RedoCard >> isPermanent [

	^ false
]
