Class {
	#name : #SpeedCard,
	#superclass : #Object,
	#instVars : [
		'holder',
		'target'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'Intance creation' }
SpeedCard class >> create [
	^ self new initializeCreate.
]

{ #category : #effect }
SpeedCard >> applyCardUsing: cardManager at: aGame to: anObjective [

	aGame isPlaying: anObjective.
	cardManager activeCard: (self class create newHolder: holder) to: anObjective
]

{ #category : #effect }
SpeedCard >> applyEffect [

	^ 1
]

{ #category : #information }
SpeedCard >> hasEffect [

	^ true
]

{ #category : #effect }
SpeedCard >> holder [

	^ holder
]

{ #category : #initialization }
SpeedCard >> initializeCreate [

	holder := EmptyObject new.
	target := EmptyObject new
]

{ #category : #information }
SpeedCard >> isEmpty [

	^ false
]

{ #category : #information }
SpeedCard >> isPermanent [

	^ true
]

{ #category : #effect }
SpeedCard >> newHolder: aHolder [

	holder := aHolder
]

{ #category : #comparing }
SpeedCard >> sameHolder: aCard [ 
	
	^ self class = aCard class and: holder = aCard holder.
]

{ #category : #comparing }
SpeedCard >> sameTarget: aCard [ 
	
	^ aCard class = self class and: target = aCard target.
]

{ #category : #initialization }
SpeedCard >> selectTarget: aNewTarget [

	target:= aNewTarget.
]

{ #category : #information }
SpeedCard >> target [

	^ target
]
