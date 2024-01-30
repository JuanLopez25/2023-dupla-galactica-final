Class {
	#name : #RedoCard,
	#superclass : #Object,
	#instVars : [
		'holder',
		'target'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'Instance creation' }
RedoCard class >> create [
	^self new intializeWith.
]

{ #category : #initialization }
RedoCard >> applyCardUsing: cardManager at: aGame to: anObjective [

	cardManager lastCardPlay isEmpty
		ifFalse: [ 
			(cardManager lastCardPlay newHolder: self)
				applyCardUsing: cardManager
				at: aGame
				to: anObjective ]
		ifTrue: [ 
			Error signal:
				'Redo card cannot be played because there are no cards that have been played before' ]
]

{ #category : #information }
RedoCard >> hasEffect [

	^ false
]

{ #category : #information }
RedoCard >> holder [

	^ holder
]

{ #category : #initialization }
RedoCard >> intializeWith [

	holder := EmptyObject new.
	target := EmptyObject new.
]

{ #category : #information }
RedoCard >> isEmpty [

	^ false
]

{ #category : #information }
RedoCard >> isPermanent [

	^ false
]

{ #category : #information }
RedoCard >> newHolder: aHolder [

	holder := aHolder
]

{ #category : #comparing }
RedoCard >> sameHolder: aCard [ 
	
	^ self class = aCard class and: holder = aCard holder.
]

{ #category : #information }
RedoCard >> selectTarget: aNewTarget [

	target:= aNewTarget.
]
