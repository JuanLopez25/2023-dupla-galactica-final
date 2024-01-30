Class {
	#name : #AccelerationCard,
	#superclass : #Object,
	#instVars : [
		'holder',
		'target'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'Intance creation' }
AccelerationCard class >> create [

	^ self new intializeCreate
]

{ #category : #effect }
AccelerationCard >> applyCardUsing: cardManager at: aGame to: anObjectiveCard [

	cardManager activeCard: (self class create) to: EveryPlayer new.
]

{ #category : #effect }
AccelerationCard >> applyEffect [

	^ 1
]

{ #category : #information }
AccelerationCard >> hasEffect [

	^ true
]

{ #category : #information }
AccelerationCard >> holder [

	^ holder
]

{ #category : #initialization }
AccelerationCard >> intializeCreate [

	holder := EmptyObject new.
	target := EveryPlayer new
]

{ #category : #information }
AccelerationCard >> isEmpty [

	^ false
]

{ #category : #information }
AccelerationCard >> isPermanent [

	^ true
]

{ #category : #effect }
AccelerationCard >> newHolder: aHolder [

	holder := aHolder
	
]

{ #category : #comparing }
AccelerationCard >> sameHolder: aCard [ 
	
	^ self class = aCard class and: holder = aCard holder.
]

{ #category : #comparing }
AccelerationCard >> sameTarget: aCard [ 
	
	^ aCard class = self class and: target = aCard target.
]

{ #category : #effect }
AccelerationCard >> selectTarget: aPlayer [



]

{ #category : #information }
AccelerationCard >> target [

	^ target
]
