import { map } from 'common/collections';
import { toFixed } from 'common/math';
import { numberOfDecimalDigits } from '../../common/math';
import { useBackend, useLocalState } from '../backend';
import { Box, Button, Collapsible, ColorBox, Dropdown, Flex, Input, LabeledList, NoticeBox, NumberInput, Section } from '../components';
import { Window } from '../layouts';
import { logger } from '../logging';


const ParticleIntegerEntry = (props, context) => {
  const { value, name } = props;
  const { act } = useBackend(context);
  return (
    <NumberInput
      value={value}
      minValue={-500}
      maxValue={500}
      stepPixelSize={5}
      width="39px"
      onDrag={(e, value) => act('modify_particle_value', {
        new_data: {
          name: name,
          value: value,
          type: 'integer',
        },
      })} />
  );
};

const ParticleMatrixEntry = (props, context) => {
  let { value, name } = props;
  const { act } = useBackend(context);


  // Actual matrix, or matrix of 0
  value = value || [0, 0, 0, 0, 0, 0];
  logger.log(JSON.stringify(value));
  return (
    <Flex>
      <Flex.Item>
        {value.map((val, i) => (
          <NumberInput
            value={val}
            key={i}
            onDrag={(e, v) =>
            {
              value[i] = v;

              act('modify_particle_value', {
                new_data: {
                  name: name,
                  value: [value],
                  type: 'matrix',
                },
              }); }}
          />))}
      </Flex.Item>
    </Flex>

  );
};

const ParticleFloatEntry = (props, context) => {
  const { value, name } = props;
  const { act } = useBackend(context);
  const [step, setStep] = useLocalState(context, 'particleFloatStep', 0.01);
  return (
    <>
      <NumberInput
        value={value}
        minValue={-500}
        maxValue={500}
        stepPixelSize={4}
        step={step}
        format={value => toFixed(value, numberOfDecimalDigits(step))}
        width="80px"
        onDrag={(e, value) =>
          act('modify_particle_value', {
            new_data: {
              name: name,
              value: value,
              type: 'float',
            },
          })} />
      <Box
        inline
        ml={2}
        mr={1}>
        Step:
      </Box>
      <NumberInput
        value={step}
        step={0.001}
        format={value => toFixed(value, 4)}
        width="70px"
        onChange={(e, value) => setStep(value)} />
    </>
  );
};

const ParticleGeneratorEntry = (props, context) => {
  const { value, name } = props;
  const { act } = useBackend(context);
  const [step, setStep] = useLocalState(context, 'particleFloatStep', 0.01);
  const generatorTypes = ["num", "vector", "box", "color", "circle", "sphere", "square", "cube"];
  const randTypes = ["UNIFORM_RAND", "NORMAL_RAND", "LINEAR_RAND", "SQUARE_RAND"];

  let workingValue = value || { genType: "", a: "", b: "", rand: "" };

  const doAct = () => act('modify_particle_value', {
    new_data: {
      name: name,
      value: {
        genType: workingValue.genType,
        a: workingValue.a,
        b: workingValue.b,
        rand: workingValue.rand,
      },
      type: 'generator',
    },
  });

  return (
    <Flex>
      <Flex.Item grow={0}>
        <Dropdown
          displayText="Type"
          nochevron
          options={generatorTypes}
          selected={workingValue.genType}
          onSelected={(e, val) => { workingValue.genType = val; }} />
      </Flex.Item>
      <Flex.Item m={1}> A: </Flex.Item>
      <Flex.Item><Input
        value={workingValue.a}
        onInput={(e, val) => { workingValue.a = val; }} />
      </Flex.Item>
      <Flex.Item m={1}> B: </Flex.Item>
      <Flex.Item><Input
        value={workingValue.b}
        onInput={(e, val) => { workingValue.b = val; }} />
      </Flex.Item>
      <Flex.Item m={1}> Rand: </Flex.Item>
      <Flex.Item>
        <Flex.Item />
        <Dropdown grow={0}
          displayText="Rand Type"
          nochevron
          options={randTypes}
          selected={workingValue.rand}
          onSelected={(e, val) => { workingValue.rand = val; }} />
      </Flex.Item>
      <Flex.Item m={1}>
        <Button
          content="Set"
          onClick={() => doAct} />
      </Flex.Item>

    </Flex>
  );
};

const ParticleTextEntry = (props, context) => {
  const { value, name } = props;
  const { act } = useBackend(context);

  return (
    <Input
      value={value}
      width="250px"
      onInput={(e, value) => act('modify_particle_value', {
        new_data: {
          name: name,
          value: value,
          type: 'text',
        },
      })} />
  );
};

const ParticleColorEntry = (props, context) => {
  const { value, name } = props;
  const { act } = useBackend(context);
  return (
    <>
      <Button
        icon="pencil-alt"
        onClick={() => act('modify_color_value')} />
      <ColorBox
        color={value}
        mr={0.5} />
      <Input
        value={value}
        width="90px"
        onInput={(e, value) => act('modify_particle_value', {
          new_data: {
            name: name,
            value: value,
            type: 'color',
          },
        })} />
    </>
  );
};

const ParticleIconEntry = (props, context) => {
  const { value } = props;
  const { act } = useBackend(context);
  return (
    <>
      <Button
        icon="pencil-alt"
        onClick={() => act('modify_icon_value')} />
      <Box inline ml={1}>
        {value}
      </Box>
    </>
  );
};


const particleEntryMap = {

  width: 'float',
  height: 'float',
  count: 'int',
  spawning: 'float',
  bound1: 'string',
  bound2: 'string',
  gravity: 'string',
  gradient: 'string',
  transform: 'matrix',


  lifespan: 'float',
  fade: 'float',
  icon: 'icon',
  icon_state: 'string',
  color: 'color',
  color_change: 'float',
  position: 'generator',
  velocity: 'generator',
  scale: 'generator',
  grow: 'generator',
  rotation: 'float',
  spin: 'float',
  friction: 'float',
  drift: 'generator',
};

const ParticleDataEntry = (props, context) => {
  const { name, value } = props;

  const particleEntryTypes = {
    int: <ParticleIntegerEntry {...props} />,
    float: <ParticleFloatEntry {...props} />,
    string: <ParticleTextEntry {...props} />,
    color: <ParticleColorEntry {...props} />,
    icon: <ParticleIconEntry {...props} />,
    generator: <ParticleGeneratorEntry {...props} />,
    matrix: <ParticleMatrixEntry {...props} />,
  };

  return (
    <LabeledList.Item label={name}>
      {particleEntryTypes[particleEntryMap[name]] || "Not Found (This is an error)"}
    </LabeledList.Item>
  );
};

const ParticleEntry = (props, context) => {
  const { act, data } = useBackend(context);
  const { particle } = props;
  return (
    <Collapsible
      title="Particle">
      <Section level={2}>
        <LabeledList>
          {Object.keys(particleEntryMap).map(entryName => {
            const value = particle[entryName];
            return (
              <ParticleDataEntry
                key={entryName}
                name={entryName}
                value={value} />
            );
          })}
        </LabeledList>
      </Section>
    </Collapsible>
  );
};

export const Particool = (props, context) => {
  const { act, data } = useBackend(context);
  const particles = data.target_particle || {};
  const hasParticles = particles && Object.keys(particles).length > 0;

  const [massApplyPath, setMassApplyPath] = useLocalState(context, 'massApplyPath', '');
  const [hiddenSecret, setHiddenSecret] = useLocalState(context, 'hidden', false);
  return (
    <Window
      title="Particool"
      width={700}
      height={500}>
      <Window.Content scrollable>
        <NoticeBox danger> {String(Date.now())} <br />
          Particles? {hasParticles.toString()} -
          {(data.target_particle === null).toString()} <br />
          dazta Json - {JSON.stringify(data.target_particle)}
        </NoticeBox>
        <Section
          title={
            <Box
              inline
              onDblClick={() => setHiddenSecret(true)}>
              Particle
            </Box>
          }
          buttons={!hasParticles ? (
            <Button
              icon="plus"
              content="Add Particle"
              onClick={() => act('add_particle')} />
          ) : (<Button.Confirm
            icon="minus"
            content="Remove Particle"
            onClick={() => act("remove_particle")} />)} >
          {!hasParticles ? (
            <Box>
              No particle
            </Box>
          ) : (
            <ParticleEntry particle={particles} />
          )}
        </Section>
      </Window.Content>
    </Window>
  );
};
