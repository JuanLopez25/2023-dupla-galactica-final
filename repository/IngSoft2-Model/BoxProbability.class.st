Class {
	#name : #BoxProbability,
	#superclass : #Object,
	#instVars : [
		'box',
		'probability'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'Instance creation' }
BoxProbability class >> using: aBox withChance: aProbability [

	^ self new initializeUsing: aBox withChance: aProbability
]

{ #category : #information }
BoxProbability >> box [

	^ box
]

{ #category : #initialization }
BoxProbability >> initializeUsing: aBox withChance: aProbability [

	box := aBox.
	probability := aProbability
]

{ #category : #information }
BoxProbability >> probability [

	^ probability
]
