Class {
	#name : #OverloadCard,
	#superclass : #Object,
	#instVars : [
		'holder',
		'target'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'Instance creation' }
OverloadCard class >> create [
	^ self new initializeCreate.
]

{ #category : #effect }
OverloadCard >> applyCardUsing: cardManager at: aGame [

	
	aGame isPlaying: target.
	cardManager activeCard: ((self class create newHolder: holder) selectTarget: target)
]

{ #category : #effect }
OverloadCard >> applyEffect [

	^ -2
]

{ #category : #information }
OverloadCard >> hasEffect [

	^ true
]

{ #category : #information }
OverloadCard >> holder [

	^ holder
]

{ #category : #initialization }
OverloadCard >> initializeCreate [

	holder := EmptyObject new.
	target := EmptyObject new
]

{ #category : #information }
OverloadCard >> isEmpty [

	^ false
]

{ #category : #information }
OverloadCard >> isPermanent [

	^ true
]

{ #category : #information }
OverloadCard >> newHolder: aHolder [

	holder := aHolder
]

{ #category : #comparing }
OverloadCard >> sameHolder: aCard [ 
	
	^ self class = aCard class and: holder = aCard holder.
]

{ #category : #comparing }
OverloadCard >> sameTarget: aCard [ 
	
	^ aCard class = self class and: target = aCard target.
]

{ #category : #information }
OverloadCard >> selectTarget: aNewTarget [

	target:= aNewTarget.
]

{ #category : #information }
OverloadCard >> target [

	^ target
]
